Feature: Prueba comprar albumes

  Como usurio de la aplicacion
  Quiero realizar una consulta de los albumes comprados
  Para ver los que fueron comprados por cada usuario

  Background: Precarga
    * def urlBase = 'https://nodejs-qa-training.herokuapp.com/'
    * def headerContentType = 'application/json'

  @ExitosoRegular
  Scenario:Comprar album con usuario regular exitoso
    * def jsonAutenticacion = call read('listar_albumes.feature@ExitosoRegular')
    * def varAuthorization = jsonAutenticacion.jsonAutenticacion.responseHeaders.Authorization[0]
    * def totalIdAlbum = jsonAutenticacion.response.length
    * def obtenerIdAlbum = function(max) { return Math.floor(Math.random() * max) }
    * def idAlbum = obtenerIdAlbum(totalIdAlbum)
    Given url urlBase + 'albums/' + idAlbum
    And header Content-Type = headerContentType
    And header Authorization = varAuthorization
    And request {}
    When method post
    Then status 201
    * print response

  @ExitosoAdministrador
  Scenario:Comprar albun con usuario administrador exitoso
    * def jsonAutenticacion = call read('listar_albumes.feature@ExitosoAdministrador')
    * def varAuthorization = jsonAutenticacion.jsonAutenticacion.responseHeaders.Authorization[0]
    * def totalIdAlbum = jsonAutenticacion.response.length
    * def obtenerIdAlbum = function(max) { return Math.floor(Math.random() * max) }
    * def idAlbum = obtenerIdAlbum(totalIdAlbum)
    Given url urlBase + 'albums/' + idAlbum
    And header Content-Type = headerContentType
    And header Authorization = varAuthorization
    And request {}
    When method post
    Then status 201
    * print response

  @Alterno
  Scenario: Comprar album con usuario administrador alterno
    * def jsonAutenticacion = call read('listar_albumes.feature@ExitosoAdministrador')
    * def varAuthorization = jsonAutenticacion.jsonAutenticacion.responseHeaders.Authorization[0]
    * def totalIdAlbum = jsonAutenticacion.response.length
    * def obtenerIdAlbum = function(max) { return Math.floor(Math.random() * max) }
    * def idAlbum = obtenerIdAlbum(totalIdAlbum)
    Given url urlBase + 'albums/' + idAlbum
    And header Content-Type = headerContentType
    And header Authorization = varAuthorization
    And request {}
    When method post
    Then status 201
    Given url urlBase + 'albums/' + idAlbum
    And header Content-Type = headerContentType
    And header Authorization = varAuthorization
    And request {}
    When method post
    Then status 422
    And match response contains read('../json/formato_error.json')