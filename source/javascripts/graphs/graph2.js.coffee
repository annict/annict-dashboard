class Ann.Graph2
  @draw: (client)->
    query = new Keen.Query "count_unique",
      eventCollection: "records"
      timeframe: "this_90_days"
      targetProperty: "user_id"
      interval: "weekly"
      filters: [
        "property_name": "action"
        "operator": "eq"
        "property_value": "create"
      ]

    client.draw query, $(".js-graph-2")[0],
      title: "週1回以上見たエピソードを記録した人 (一括記録を除く)"
      width: "auto"
