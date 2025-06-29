package org.ts.teamstack.payment.model.dto;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;

@Getter
@NoArgsConstructor
@AllArgsConstructor
public class PortOneTokenResponse {
    private  int code;
    private  String message;
    private  TokenData response;



    @Getter
    @NoArgsConstructor
    @AllArgsConstructor
    public static class TokenData {
        private  String access_token;
        private  long now;
        private  long expired_at;


    }
}
