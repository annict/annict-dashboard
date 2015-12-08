class Ann.Graph3
  @draw: (client) ->
    allRecords = new Keen.Query "count",
      eventCollection: "records"
      timeframe: "this_90_days"
      interval: "daily"
      filters: [
        "property_name": "action"
        "operator": "eq"
        "property_value": "create"
      ]

    pcRecords = new Keen.Query "count",
      eventCollection: "records"
      timeframe: "this_90_days"
      interval: "daily"
      filters: [{
        "property_name": "action"
        "operator": "eq"
        "property_value": "create"
      }, {
        "property_name": "device"
        "operator": "eq"
        "property_value": "pc"
      }]

    mobileRecords = new Keen.Query "count",
      eventCollection: "records"
      timeframe: "this_90_days"
      interval: "daily"
      filters: [{
        "property_name": "action"
        "operator": "eq"
        "property_value": "create"
      }, {
        "property_name": "device"
        "operator": "eq"
        "property_value": "mobile"
      }]

    chart = new Keen.Dataviz()
      .el($('.js-graph-3')[0])
      .chartType("linechart")
      .colors(["#9c27b0", "#2196f3", "#f44336"])
      .title("エピソード記録数 (一括記録を除く)")
      .width("auto")
      .prepare()

    client.run [allRecords, pcRecords, mobileRecords], (err, res) ->
      return chart.error(err.message) if err

      result1 = res[0].result
      result2 = res[1].result
      result3 = res[2].result
      data = []

      _.forEach result1, (val, i) ->
        data[i] =
          timeframe: val["timeframe"]
          value: [
            { category: "全て", result: val["value"] }
            { category: "PC", result: result2[i]["value"] }
            { category: "モバイル", result: result3[i]["value"] }
          ]
        chart
          .parseRawData(result: data)
          .render()
