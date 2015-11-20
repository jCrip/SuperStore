@buildMap = (markers) ->
  handler = Gmaps.build 'Google'
  handler.buildMap { provider: {}, internal: {id: 'map'} }, ->
    markers = handler.addMarkers(markers)
    handler.bounds.extendWith(markers)
    handler.fitMapToBounds()
    for marker in markers
      google.maps.event.addListener marker, 'click', ->
        alert "hello"
        true
      true