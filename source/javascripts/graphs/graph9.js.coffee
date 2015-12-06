class Ann.Graph9
  @draw: (client)->
    query = new Keen.Query "count_unique",
      eventCollection: "follows"
      timeframe: "this_90_days"
      targetProperty: "user_id"
      interval: "daily"
      filters: [
        "property_name": "action"
        "operator": "eq"
        "property_value": "create"
      ]

    client.draw query, $(".js-graph-9")[0],
      title: "フォロー機能を利用した人"
      width: "auto"
