Feature: Prueba listar albumes

  Como usurio de la aplicacion
  Quiero realizar una consulta a los albumes
  Para ver los albumes creados

  Background: Precarga
    * def urlBase = 'https://nodejs-qa-training.herokuapp.com/'
    * def headerContentType = 'application/json'

  @ExitosoRegular
  Scenario: Listar albumes con usuario regular exitoso
    * def jsonAutenticacion = call read('autenticar_usuario.feature@ExitosoRegular')
    * def varAuthorization = jsonAutenticacion.responseHeaders.Authorization[0]
    Given url urlBase + 'albums'
    And header Content-Type = headerContentType
    And header Authorization = varAuthorization
    When method get
    Then status 200
    * def objeto = read('../json/formato_albumes.json')
    And match each response contains objeto

  @ExitosoAdministrador
  Scenario: Listar albumes con usuario administrador exitoso
    * def jsonAutenticacion = call read('autenticar_usuario.feature@ExitosoAdministrador')
    * def varAuthorization = jsonAutenticacion.responseHeaders.Authorization[0]
    Given url urlBase + 'albums'
    And header Content-Type = headerContentType
    And header Authorization = varAuthorization
    When method get
    Then status 200
    * def objeto = read('../json/formato_albumes.json')
    And match each response contains objeto

    @Alterno
  Scenario: Listar albumes escenario alterno
    * def jsonAutenticacion = call read('autenticar_usuario.feature@ExitosoRegular')
    Given url urlBase + 'albums'
    And header Content-Type = headerContentType
    And header Authorization = 'kadjADAhOLAIyysfhkalsdHKLsdASDADGDFGJD'
    When method get
    Then status 401
    And match response contains read('../json/formato_error.json')