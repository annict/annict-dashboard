class Ann.Graph8
  @draw: (client)->
    query = new Keen.Query "count_unique",
      eventCollection: "likes"
      timeframe: "this_90_days"
      targetProperty: "user_id"
      interval: "daily"
      filters: [
        "property_name": "action"
        "operator": "eq"
        "property_value": "create"
      ]

    client.draw query, $(".js-graph-8")[0],
      title: "Like機能を利用した人"
      width: "auto"
