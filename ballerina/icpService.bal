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

listener http:Listener securedEP = new (icpServicePort,
    secureSocket = {
        key: {
            path: keyStorePath,
            password: keyStorePassword
        }
    }
);

service /management on securedEP {

    resource function get login() returns AccessTokenResponse|error {
        return {AccessToken: jwt};
    }

    resource function get [string resourceType](string? searchKey)
                                            returns Artifacts|error {

        Artifacts artifacts = {
            count: 0,
            list: [
                {
                    name: "api",
                    url: "http://localhost:8290/test"
                },
                {
                    name: "helloApi",
                    url: "http://localhost:8290/api"
                }
            ]
        };
        return artifacts;
    }

}
