// Copyright (c) 2024, WSO2 LLC. (https://www.wso2.com).
//
// WSO2 Inc. licenses this file to you under the Apache License,
// Version 2.0 (the "License"); you may not use this file except
// in compliance with the License.
// You may obtain a copy of the License at
//
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing,
// software distributed under the License is distributed on an
// "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
// KIND, either express or implied.  See the License for the
// specific language governing permissions and limitations
// under the License.

import ballerina/http;
import ballerina/jballerina.java;
import ballerina/lang.runtime;
import ballerina/log;

type ArtifactsResponse record {|
   Service[] services?;
   ConfigVariable[] configVariables?;
|};

type DashBoard record {
   string url;
   int heartbeatInterval = 5;
   string groupId;
   string nodeId;
};

type Service record {|
   string basePath;
   Resource[] resources;
   Listener listenerObj;
|};

type Resource record {|
   string accessor;
   Parameter[] pathParams;
   Parameter[] queryParam;
   string responseType;
|};

type Parameter record {|
   string name;
   string 'type;
|};

type Listener record {|
   int port;
|};

type ConfigVariable record {|
   string name;
   string 'type;
   Module module;
   anydata value;
|};

type Module record {|
   string name;
   string org;
   string version;
|};

configurable DashBoard dashboard = ?;

service /management on new http:Listener(9164) {

   function init() returns error? {
       worker w1 returns error? {
           check self.registerInDashboardServer();
       }
   }

   resource function get [string resourceType](string? searchKey) returns ArtifactsResponse|error {
       return self.getArtifacts();
   }

   function registerInDashboardServer() returns error? {
       http:Client dsClient = check new (dashboard.url);
       while (true) {
           http:Response|http:ClientError resp = dsClient->post("/connection", {});
           if (resp is error) {
               log:printError(string `Connection to dashboard server ${dashboard.url} is failed.
                   Retrying after ${dashboard.heartbeatInterval} minutes.`);
               runtime:sleep(dashboard.heartbeatInterval * 60);
           } else {
               log:printInfo(string `Connected to dashboard server ${dashboard.url}`);
               break;
           }
       }
   }

   function getArtifacts() returns ArtifactsResponse = @java:Method {
       'class: "org.ballerinalang.stdlib.runtime.management.RuntimeManager"
   } external;
}
