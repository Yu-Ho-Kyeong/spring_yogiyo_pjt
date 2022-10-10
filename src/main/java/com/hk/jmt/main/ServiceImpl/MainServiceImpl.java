package com.hk.jmt.main.ServiceImpl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.hk.jmt.main.Dao.MainDao;
import com.hk.jmt.main.Service.MainService;
import com.hk.jmt.main.Vo.mainCategoryVo;

@Service
public class MainServiceImpl implements MainService {

	@Autowired
	private MainDao dao;
	
	@Override
	public List<mainCategoryVo> getCategory() {
		List<mainCategoryVo> result = dao.getCategory(); 
		
		return result;
	}
	

}
