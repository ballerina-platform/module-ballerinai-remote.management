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

type IntegrationPlaneConnectionRequest record {
    string product = "mi";
    string groupId;
    string nodeId;
    int interval;
    string mgtApiUrl;
    ChangeNotification changeNotification = {
        deployedArtifacts: [],
        undeployedArtifacts: [],
        stateChangedArtifacts: []
    };
};

type ChangeNotification record {
    anydata[] deployedArtifacts;
    anydata[] undeployedArtifacts;
    anydata[] stateChangedArtifacts;
};

type AccessTokenResponse record {|
    string AccessToken;
|};

type Artifacts record {
    int count;
    Artifact[] list;
};

type Artifact Service;

type Service record {
    string name;
    string url;
};

type DashBoard record {
    string url = "";
    int heartbeatInterval = 10;
    decimal waitTimeForServicesInSeconds = 5;
    string groupId = "";
    string nodeId = "";
    string mgtApiUrl = "";
};

type AccessToken record {|
    string AccessToken;
|};
