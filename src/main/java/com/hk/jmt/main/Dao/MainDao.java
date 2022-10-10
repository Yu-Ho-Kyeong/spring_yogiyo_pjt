package com.hk.jmt.main.Dao;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.hk.jmt.common.Dao.AbstractDAO;
import com.hk.jmt.main.Vo.mainCategoryVo;

@Repository
public class MainDao extends AbstractDAO {
	@Autowired
	private SqlSessionTemplate sql;
	
	public List<mainCategoryVo> getCategory() {
		return sql.selectList("mainCategorySql.getCategory");
	}

}
