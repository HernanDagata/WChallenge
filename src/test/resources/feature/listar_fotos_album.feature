Feature: Prueba listar fotos de un album

  Como usurio de la aplicacion
  Quiero realizar una consulta las fotos
  Para ver las que componen un album

  Background: Precarga
    * def urlBase = 'https://nodejs-qa-training.herokuapp.com/'
    * def headerContentType = 'application/json'

  Scenario: Listar albumes con usuario regular exitoso
    * def jsonAutenticacion = call read('listar_albumes.feature@ExitosoRegular')
    * def varAuthorization = jsonAutenticacion.jsonAutenticacion.responseHeaders.Authorization[0]
    * def totalIdAlbum = jsonAutenticacion.response.length
    * def obtenerIdAlbum = function(max) { return Math.floor(Math.random() * max) }
    * def idAlbum = obtenerIdAlbum(totalIdAlbum)
    * print idAlbum
    Given url urlBase + 'albums/' + idAlbum + '/photos'
    And header Content-Type = headerContentType
    And header Authorization = varAuthorization
    When method get
    Then status 200
    * print response
    * def objeto = read('../json/formato_fotos.json')
    And match each response contains objeto

  Scenario: Listar albumes con usuario administrador exitoso
    * def jsonAutenticacion = call read('listar_albumes.feature@ExitosoAdministrador')
    * print jsonAutenticacion
    * def varAuthorization = jsonAutenticacion.jsonAutenticacion.responseHeaders.Authorization[0]
    * print varAuthorization
    * def totalIdAlbum = jsonAutenticacion.response.length
    * print totalIdAlbum
    * def obtenerIdAlbum = function(max) { return Math.floor(Math.random() * max) }
    * def idAlbum = obtenerIdAlbum(totalIdAlbum)
    * print idAlbum
    Given url urlBase + 'albums/' + idAlbum + '/photos'
    And header Content-Type = headerContentType
    And header Authorization = varAuthorization
    When method get
    Then status 200
    * print response
    * def objeto = read('../json/formato_fotos.json')
    And match each response contains objeto

  Scenario: Listar albumes escenario alterno
    * def jsonAutenticacion = call read('autenticar_usuario.feature@ExitosoRegular')
    Given url urlBase + 'albums'
    And header Content-Type = headerContentType
    And header Authorization = 'kadjADAhOLAIyysfhkalsdHKLsdASDADGDFGJD'
    When method get
    Then status 401
    And match response contains read('../json/formato_error.json')