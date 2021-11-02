Feature: Get enrollment details through POST call in wfl-claims-rs Core Services

 Background:
  * url baseUrl
  * header Authorization = call read('basic-auth.js')

 @reg
 Scenario Outline: Validate get master policy details for given Policy number : <Policy_number>
  Given path 'policy-group-enrollment-rs/v1/enrollment/<Policy_number>/status'
  When method GET
  Then status 200
  Then print response
  * def data = response.records
  * def myFun =
    """
    function(arg) {
     for(i=0; i<arg.length; i++){
       if(arg[i].referenceId == <ref_id_test>){
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
   | Policy_number | ref_id_test    |
   | MP0000783678  | 20211029013309 |
   | MP0000783678  | 20211027082623 |