package org.ts.teamstack.payment.model.dto;


import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.RequiredArgsConstructor;

@Getter
@AllArgsConstructor
@NoArgsConstructor
public class PortOneTokenRequest {

    private  String imp_key;
    private  String imp_secret ;

}
