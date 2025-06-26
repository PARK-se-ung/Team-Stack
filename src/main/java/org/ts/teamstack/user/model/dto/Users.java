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
import java.io.Serializable;
import java.sql.Date;
import java.sql.Timestamp;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.Collection;
import java.util.List;

import static org.ts.teamstack.user.model.dto.UserType.G;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder

public class Users implements UserDetails{

    @Override
    public Collection<? extends GrantedAuthority> getAuthorities() {
        List<GrantedAuthority> athu = new ArrayList<>();
        SimpleGrantedAuthority a = null;

        if (userType == null) {
            athu.add(new SimpleGrantedAuthority("General"));
            return athu;
        }

        switch(userType) {
            case A : a = new SimpleGrantedAuthority("Admin");
                break;
            case I : a = new SimpleGrantedAuthority("Instructor");
                break;
            default : a = new SimpleGrantedAuthority("General");
                break;
        }
        athu.add(a);
        return athu;
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
    @NotEmpty(message = "아이디는 필수값입니다.")
    @Size(min= 6, message = "아이디는 6글자 이상입니다.")
    private String userId;
    @NotEmpty(message = "비밀번호는 필수값입니다.")
    @Pattern(regexp = "(?=.*[0-9])(?=.*[A-Z])(?=.*[!@#$%^&*()])[\\da-zA-Z!@#$%^&*()]{9,}",
            message = "특수기호,대문자,숫자포함 9글자 이상입니다.")
    private String userPwd;
    @NotEmpty(message = "이름은 필수값입니다.")
    private String name;
    @NotEmpty(message = "이메일은 필수값입니다.")
    private String userEmail;
    private Timestamp userCreateTime = new Timestamp(System.currentTimeMillis());
    private UserType userType= G;
    @NotEmpty
    private String userPhone;
    @NotEmpty
    private String userAddress;
}
