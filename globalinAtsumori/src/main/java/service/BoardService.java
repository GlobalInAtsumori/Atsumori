package service;

import org.springframework.stereotype.Service;

import dto.BoardUpdateDTO;
import lombok.RequiredArgsConstructor;
import mapper.BoardMapper;

@Service
@RequiredArgsConstructor
public class BoardService {

	private final BoardMapper boardMapper;
	
	public BoardUpdateDTO update(int boardNo) {
		return boardMapper.boardUpdate(boardNo);
	}
}
