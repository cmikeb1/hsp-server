/*
 * #%L
 * hsp-reference-api
 * %%
 * Copyright (C) 2014 - 2015 Healthcare Services Platform Consortium
 * %%
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 * 
 *      http://www.apache.org/licenses/LICENSE-2.0
 * 
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 * #L%
 */

package org.hspconsortium.platform.launchcontext;

import com.sun.org.apache.xerces.internal.impl.dv.util.Base64;
import org.apache.http.HttpEntity;
import org.apache.http.HttpRequest;
import org.apache.http.client.ClientProtocolException;
import org.apache.http.client.methods.CloseableHttpResponse;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.entity.StringEntity;
import org.apache.http.impl.client.CloseableHttpClient;
import org.apache.http.impl.client.HttpClients;
import org.apache.http.util.EntityUtils;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.UnsupportedEncodingException;

@Controller
public class LaunchOrchestrationEndpoint {
    @Value("${api.authorizationServerLaunchEndpointURL}")
    private String authorizationServerLaunchEndpointURL;
    @Value("${api.apiServerClientId}")
    private String apiServerClientId;
    @Value("${api.apiServerClientSecret}")
    private String apiServerClientSecret;

    @RequestMapping(value = "/smart/Launch", method = RequestMethod.POST)
    public void handleLaunchRequest(HttpServletRequest request, HttpServletResponse response, @RequestBody String jsonString) {
        HttpPost postRequest = new HttpPost(this.authorizationServerLaunchEndpointURL);
        postRequest.addHeader("Content-Type", "application/json");
        StringEntity entity = null;
        try {
            entity = new StringEntity(jsonString);
            postRequest.setEntity(entity);

            setAuthorizationHeader(postRequest, apiServerClientId, apiServerClientSecret);
        } catch (UnsupportedEncodingException uee_ex) {
            throw new RuntimeException(uee_ex);
        }

        CloseableHttpClient httpClient = HttpClients.custom().build();

        try (CloseableHttpResponse closeableHttpResponse = httpClient.execute(postRequest)) {
            if(closeableHttpResponse.getStatusLine().getStatusCode() != 200) {
                HttpEntity rEntity = closeableHttpResponse.getEntity();
                String responseString = EntityUtils.toString(rEntity, "UTF-8");
                throw new RuntimeException(String.format("There was a problem with the registration the Launch Context.\n" +
                        "Response Status : %s .\nResponse Detail :%s."
                        , closeableHttpResponse.getStatusLine()
                        , responseString));
            }
            response.setHeader("Content-Type", "application/json;charset=utf-8");
            response.getWriter().write( EntityUtils.toString(closeableHttpResponse.getEntity()));
        } catch (ClientProtocolException cpe_ex) {
            throw new RuntimeException(cpe_ex);
        } catch (IOException io_ex) {
            throw new RuntimeException(io_ex);
        }
    }

    protected static void setAuthorizationHeader(HttpRequest request, String clientId, String clientSecret) {
        String authHeader = String.format("%s:%s", clientId, clientSecret == null ? "" : clientSecret);
        String encoded = Base64.encode(authHeader.getBytes());
        request.addHeader("Authorization", String.format("Basic %s", encoded));
    }
}
