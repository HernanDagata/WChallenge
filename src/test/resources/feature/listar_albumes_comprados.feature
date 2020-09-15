Feature: Prueba listar los albumes comprados

  Como usurio de la aplicacion
  Quiero realizar una consulta de los albumes comprados
  Para ver los que fueron comprados por cada usuario

  Background: Precarga
    * def urlBase = 'https://nodejs-qa-training.herokuapp.com/'
    * def headerContentType = 'application/json'

  @ExitosoRegular
  Scenario: Listar albumes con usuario regular exitoso
    * def jsonAutenticacion = call read('listar_albumes.feature@ExitosoRegular')
    * def varAuthorization = jsonAutenticacion.jsonAutenticacion.responseHeaders.Authorization[0]
    * def idUsuario = jsonAutenticacion.jsonAutenticacion.response.user_id
    * print idUsuario
    Given url urlBase + 'users/' + idUsuario + '/albums'
    And header Content-Type = headerContentType
    And header Authorization = varAuthorization
    When method get
    Then status 200
    And match each response contains {"user_id": #(idUsuario)}
    * def objeto = read('../json/formato_albumes_comprados.json')
    And match each response contains objeto

  @ExitosoAdministrador
  Scenario: Listar albumes con usuario administrador exitoso
    * def jsonAutenticacion = call read('listar_albumes.feature@ExitosoAdministrador')
    * def varAuthorization = jsonAutenticacion.jsonAutenticacion.responseHeaders.Authorization[0]
    * def idUsuario = jsonAutenticacion.jsonAutenticacion.response.user_id
    * print idUsuario
    Given url urlBase + 'users/' + idUsuario + '/albums'
    And header Content-Type = headerContentType
    And header Authorization = varAuthorization
    When method get
    Then status 200
    And match each response contains {"user_id": #(idUsuario)}
    * def objeto = read('../json/formato_albumes_comprados.json')
    And match each response contains objeto

  @Alterno
  Scenario: Listar albumes con usuario administrador alterno
    * def jsonAutenticacion = call read('listar_albumes.feature@ExitosoRegular')
    * def idUsuario = jsonAutenticacion.jsonAutenticacion.response.user_id
    * print idUsuario
    Given url urlBase + 'users/' + idUsuario + '/albums'
    And header Content-Type = headerContentType
    And header Authorization = 'kadjADAhOLAIyysfhkalsdHKLsdASDADGDFGJD'
    When method get
    Then status 401
    And match response contains read('../json/formato_error.json')