Feature: Posting enrollment details through POST call in wfl-claims-rs Core Services

  Background:
    * url baseUrl
    * header Authorization = call read('basic-auth.js')
    * def req_headers = {Content-Type: 'application/xml', X-Correlation-Id: '123456'}
    * def payload1 = read('classpath:dex/data/enrollmentService.xml')
    * def getDate = karate.read('getCurrentTime.js')
    * def ref_id = getDate()
    * print '=====Reference Id is======:', ref_id
    #*  header Authorization = call read('basic-auth.js') { username: 'qa', password: 'qa' }
  @smoke
  Scenario Outline: Validate post enrollment service for given master policy number : <Policy_number>
    * set payload1 /EnrollmentCensusRequest/fileMetaData/masterPolicyNumber = '<Policy_number>'
    * set payload1 /EnrollmentCensusRequest/enrollmentCensusRecords/allParticipants/firstName = ref_id
    * set payload1 /EnrollmentCensusRequest/enrollmentCensusRecords/allParticipants/lastName = ref_id
    * set payload1 /EnrollmentCensusRequest/enrollmentCensusRecords/referenceID = ref_id
    Given request payload1
    And path 'policy-group-enrollment-rs/v1/enrollment/<Policy_number>/deploy/'
    And headers req_headers
    When method POST
    Then status 200
    Then print response
     # * match response == '#array'
    * print '=========Validating field values in response================= :'
    * match response.policyNumber == '<Policy_number>'
    * def sleep = function(millis){ java.lang.Thread.sleep(millis) }
    * sleep(20000)
    * header Authorization = call read('basic-auth.js')
    Given path 'policy-group-enrollment-rs/v1/enrollment/<Policy_number>/status'
    And method GET
    When status 200
    Then print response
    * def data = response.records
    * def myFun =
    """
    function(arg) {
     for(i=0; i<arg.length; i++){
       if(arg[i].referenceId == ref_id){
           return arg[i]
           }
       }
     }
    """
    * def numberOfrecords = call myFun data
    * print  numberOfrecords
    * print '=========Validating field values in response================= :'
    * match response.policyNumber == '<Policy_number>'

    Examples:
      | Policy_number |
      | MP0000783678  |

