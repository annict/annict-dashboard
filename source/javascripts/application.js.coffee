//= require_tree ./vendor

client = new Keen
  projectId: '54382188bcb79c43eae99ae8'
  readKey: '2e49d152db65133cf8b279a08985c273842713cf31ad31eb08c104cbd552672e0070b06d72772e539dec0957f9b72b1209dd87c9f86d70bbf851d0700d4731f9788a35bcb5cedf6d9635f57d2c984893c7704aa597d8b3400669507b4be6cfec638928b1769329e20d89943d4b4db149'

Keen.ready ->
  query = new Keen.Query 'count',
    eventCollection: 'users'
    timeframe: 'this_90_days'
    interval: 'daily'
    filters: [
      { 'property_name': 'action', 'operator': 'eq', 'property_value': 'create' }
    ]
  client.draw query, $('.js-graph-1')[0],
    title: '新規ユーザ'
    width: 'auto'


  query = new Keen.Query 'count_unique',
    eventCollection: 'checkins'
    timeframe: 'this_180_days'
    targetProperty: 'user_id'
    interval: 'weekly'
    filters: [
      { 'property_name': 'action', 'operator': 'eq', 'property_value': 'create' }
    ]
  client.draw query, $('.js-graph-2')[0],
    title: '週1回以上チェックインしているユーザ'
    width: 'auto'


  newUsers = new Keen.Query 'count',
    eventCollection: 'users'
    timeframe: 'this_180_days'
    interval: 'weekly'
    filters: [
      { 'property_name': 'action', 'operator': 'eq', 'property_value': 'create' }
    ]
  firstCheckins = new Keen.Query 'count',
    eventCollection: 'first_checkins'
    timeframe: 'this_180_days'
    interval: 'weekly'
    filters: [
      { 'property_name': 'action', 'operator': 'eq', 'property_value': 'create' }
    ]
  client.run [newUsers, firstCheckins], (res) ->
    result1 = res[0].result
    result2 = res[1].result
    data = []

    _.forEach result1, (val, i) ->
      data[i] =
        timeframe: val['timeframe']
        value: [
          { category: '新規ユーザ', result: val['value'] }
          { category: '初めてチェックインしたユーザ', result: result2[i]['value'] }
        ]
    new Keen.Visualization { result: data }, $('.js-graph-3')[0],
      chartType: 'linechart'
      title: '新規ユーザがチェックインしてくれているかどうか'
      width: 'auto'
      chartOptions:
        hAxis:
          format: 'yyyy年M月'
          gridlines: { count: 12 }


  checkins = new Keen.Query 'count',
    eventCollection: 'checkins'
    timeframe: 'this_180_days'
    interval: 'weekly'
    filters: [
      { 'property_name': 'action', 'operator': 'eq', 'property_value': 'create' }
    ]
  checkinsWithComment = new Keen.Query 'count',
    eventCollection: 'checkins'
    timeframe: 'this_180_days'
    interval: 'weekly'
    filters: [
      { 'property_name': 'action', 'operator': 'eq', 'property_value': 'create' }
      { 'property_name': 'has_comment', 'operator': 'eq', 'property_value': true }
    ]
  client.run [checkins, checkinsWithComment], (res) ->
    result1 = res[0].result
    result2 = res[1].result
    data = []

    _.forEach result1, (val, i) ->
      data[i] =
        timeframe: val['timeframe']
        value: [
          { category: '全てチェックイン', result: val['value'] }
          { category: 'コメント付きチェックイン', result: result2[i]['value'] }
        ]
    new Keen.Visualization { result: data }, $('.js-graph-4')[0],
      chartType: 'linechart'
      title: '全てのチェックインとコメント付きチェックイン'
      width: 'auto'
      chartOptions:
        hAxis:
          format: 'yyyy年M月'
          gridlines: { count: 12 }
