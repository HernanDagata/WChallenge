Feature: Prueba listar usuarios

  Como usurio de la aplicacion
  Quiero realizar una consulta a los usuarios creados
  Para ver los usuarios

  Background: Precarga
    * def urlBase = 'https://nodejs-qa-training.herokuapp.com/'
    * def headerContentType = 'application/json'

  Scenario: Listar usuarios con usuario regular exitoso
    * def jsonAutenticacion = call read('autenticar_usuario.feature@ExitosoRegular')
    * def varAuthorization = jsonAutenticacion.responseHeaders.Authorization[0]
    Given url urlBase + 'users'
    And header Content-Type = headerContentType
    And header Authorization = varAuthorization
    When method get
    Then status 200
    * def objeto = read('../json/formato_usuarios.json')
    And match each response.page contains objeto.page[0]
    And match response == read('../json/formato_paginacion.json')

  Scenario: Listar usuarios con usuario administrador exitoso
    * def jsonAutenticacion = call read('autenticar_usuario.feature@ExitosoAdministrador')
    * def varAuthorization = jsonAutenticacion.responseHeaders.Authorization[0]
    Given url urlBase + 'users'
    And header Content-Type = headerContentType
    And header Authorization = varAuthorization
    When method get
    Then status 200
    * def objeto = read('../json/formato_usuarios.json')
    And match each response.page contains objeto.page[0]
    And match response == read('../json/formato_paginacion.json')

  Scenario: Listar usuarios con usuario regular escenario alterno
    * def jsonAutenticacion = call read('autenticar_usuario.feature@ExitosoRegular')
    Given url urlBase + 'users'
    And header Content-Type = headerContentType
    And header Authorization = 'kadjADAhOLAIyysfhkalsdHKLsdASDADGDFGJD'
    When method get
    Then status 401
    And match response contains read('../json/formato_error.json')