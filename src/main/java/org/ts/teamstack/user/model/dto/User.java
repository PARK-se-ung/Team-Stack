package org.ts.teamstack.user.model.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;

import javax.validation.constraints.NotEmpty;
import javax.validation.constraints.Pattern;
import javax.validation.constraints.Size;
import java.sql.Date;
import java.util.Collection;
import java.util.List;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder

public class User implements UserDetails {
    @NotEmpty(message = "아이디 값은 필수값 입니다.")
    @Size(min = 6, message = "아이디 6글자 이상입니다.")
    private String userId;
    @Pattern(regexp = "(?=.*[0-9])(?=.*[A-Z])(?=.*[!@#$%^&*()])[\\da-zA-Z!@#$%^&*()]{8,}",
            message = "특수기호,대문자,숫자포함 9글자로 작성해주세요 :(")
    private String userPwd;
    @Pattern(regexp = "[가-힝a-zA-Z]{2,}",message="이름은 한글,영문자 2글자이상 입니다.")
    private String userName;
    @NotEmpty(message = "Email은 필수로 입력해주셔야 합니다.")
    private String userEmail;
    private String userAddress;
    private Date userCreateTime;
    private String userType;
    @NotEmpty
    private String userPhone;

    @Override
    public Collection<? extends GrantedAuthority> getAuthorities() {
        return List.of(new SimpleGrantedAuthority("ROLE_" + userType));
    }

    @Override
    public String getPassword() {
        return userPwd;
    }

    @Override
    public String getUsername() {
        return userId;
    }

    @Override
    public boolean isAccountNonExpired() {
        return true;
    }

    @Override
    public boolean isAccountNonLocked() {
        return true;
    }

    @Override
    public boolean isCredentialsNonExpired() {
        return true;
    }

    @Override
    public boolean isEnabled() {
        return true;
    }
}

