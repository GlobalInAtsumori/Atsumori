package dto;

import java.sql.Date;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class BoardUpdateDTO {
	int boardNo;
    String title; 
    String content; 
    Date createDate; 
    int memberNo;
}
