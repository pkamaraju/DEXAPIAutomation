Feature: Posting enrollment details through POST call in wfl-claims-rs Core Services

  Background:
    * url baseUrl
    * header Authorization = call read('basic-auth.js')
    * def req_headers = {Content-Type: 'application/xml', X-Correlation-Id: '123456'}
    * def payload1 = read('classpath:dex/data/enrollmentService.xml')

    #*  header Authorization = call read('basic-auth.js') { username: 'qa', password: 'qa' }
  @reg
  Scenario Outline: Validate post enrollment service with duplicate status for given master policy number : <Policy_number>
    * set payload1 /EnrollmentCensusRequest/fileMetaData/masterPolicyNumber = '<Policy_number>'
    * set payload1 /EnrollmentCensusRequest/enrollmentCensusRecords/referenceID = '<ref_id>'
    Given request payload1
    And path 'policy-group-enrollment-rs/v1/enrollment/<Policy_number>/deploy/'
    And headers req_headers
    When method POST
    Then status 200
    Then print response
     # * match response == '#array'
    * print '=========Validating field values in response================= :'
    * match response.policyNumber == '<Policy_number>'

    Examples:
      | Policy_number | ref_id       |
      | MP0000783678  |20211101100845|
