script "lib_Xapi"
--> MetaData
-
copyright: Anonymous
license: GPLv3
name: lib_Xapi
type: library
version: 0.1

/*Some help*/


--> Working on
-


--> Xapi
-
function xapi_GetSecret
   return "PHgQuU5a!fHuECT"
end xapi_GetSecret

function xapi_GetUser
   return "fortyfoxes"
end xapi_GetUser

function xapi_GetEndPoint
   put xapi_GetUser() into xapiUser
   put xapi_GetSecret() into xapiSecret
   put "https://" & xapiUser & ":" & URLEncode(xapiSecret) into restUrl
   put "@" & "sample-lrs-budhujk.lrs.io:443/xapi/" after restUrl
   return restUrl
   --
   return "https://sample-lrs-budhujk.lrs.io:443/xapi/"
end xapi_GetEndPoint

function xapi_ConstructStatement
   put "fd41c918-b88b-4b20-a0a5-a4c32391aaa0" into jsonArray ["id"]
   put "2015-11-18T12:17:00+00:00" into jsonArray ["timestamp"]
   --
   put "Agent" into jsonArray ["actor"]["objectType"]
   put "Project Tin Can API" into jsonArray ["actor"]["name"]
   put "mailto:user@example.com" into jsonArray ["actor"]["mbox"]
   --
   put "http://example.com/xapi/verbs#sent-a-statement" into jsonArray ["verb"]["id"]
   put "sent" into jsonArray ["verb"]["display"]["en_US"]
   --
   put "http://example.com/xapi/activity/simplestatement" into jsonArray ["object"]["id"]
   put "simple statement" into jsonArray ["object"]["definition"]["name"]["en_US"]
   get "A simple Experience API statement. Note that the LRS does not need to have any prior information about the Actor (learner), the verb, or the Activity/object."
   put it into jsonArray ["object"]["description"]["en_US"]
   --
   put json_FromArray (jsonArray) into xapiJSON
   return xapiJSON
end xapi_ConstructStatement


--> Deps
-
command xapi_Test
   put xapi_GetEndPoint() into restUrl 
   put xapi_ConstructStatement() into xapiJSON
   --
   -- put jsonrpc_Post (someJSON, restUrl, pOAuthToken, pExtraHeaders)
   put "X-Experience-API-Version: 1.0.3" into extraHeaders
   rest_SetJsonHeaders empty, empty, extraHeaders
   post xapiJSON to url restUrl
   put it into jsonResult
   put jsonResult
end xapi_Test
