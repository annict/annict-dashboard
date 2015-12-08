class Ann.Graph6
  @draw: (client)->
    query = new Keen.Query "count_unique",
      eventCollection: "statuses"
      timeframe: "this_90_days"
      targetProperty: "user_id"
      interval: "weekly"
      filters: [
        "property_name": "action"
        "operator": "eq"
        "property_value": "create"
      ]

    client.draw query, $(".js-graph-6")[0],
      title: "週1回以上ステータスを変更した人"
      width: "auto"
