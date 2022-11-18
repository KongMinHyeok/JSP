package dao;

import java.util.ArrayList;
import java.util.List;

import db.DBHelper;
import vo.CustomerVO;

public class CustomerDAO extends DBHelper{

	private static CustomerDAO instance = new CustomerDAO();
	public static CustomerDAO getInstance() {
		return instance;
	}
	
	private CustomerDAO() {}
	
	public CustomerVO selectBook (String CusName) {
		CustomerVO vo = null;
		
		try {
			conn = getConnection();
			psmt = conn.prepareStatement("select * from `customer` where `CusName`=?");
			psmt.setString(1, CusName);
			rs = psmt.executeQuery();
			
			if(rs.next()) {
				vo = new CustomerVO();
				vo.setCusId(rs.getInt(1));
				vo.setCusName(rs.getString(2));
				vo.setCusAddr(rs.getString(3));
				vo.setCusHp(rs.getString(4));
			}
			
			close();
			
		}catch (Exception e) {
			e.printStackTrace();
		}
		return vo;
	}
	
	public List<CustomerVO> selectCustomers() {
		
		List<CustomerVO> customers = new ArrayList<>();
		
		try {
			conn = getConnection();
			stmt = conn.createStatement();
			rs = stmt.executeQuery("select * from `customer`");
			
			while(rs.next()) {
				CustomerVO vo = new CustomerVO();
				vo.setCusId(rs.getInt(1));
				vo.setCusName(rs.getString(2));
				vo.setCusAddr(rs.getString(3));
				vo.setCusHp(rs.getString(4));
				customers.add(vo);
			}
			
			close();
			
		}catch (Exception e) {
			e.printStackTrace();
		}
		return customers;
		
	}
	public void insertCustomer (CustomerVO vo) {
		
		try {
			conn = getConnection();
			psmt = conn.prepareStatement("insert into `customer` values (?,?,?,?)");
			psmt.setInt(1, vo.getCusId());
			psmt.setString(2, vo.getCusName());
			psmt.setString(3, vo.getCusAddr());
			psmt.setString(4, vo.getCusHp());
			psmt.executeUpdate();
			close();
		}catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	public void modifyCustomer (CustomerVO vo) {
		try {
			conn = getConnection();
			psmt = conn.prepareStatement("update `customer` set `CusName`=?, `CusAddr`=?, `CusHp`=? where `CusId`=?");
			psmt.setString(1, vo.getCusName());
			psmt.setString(2, vo.getCusAddr());
			psmt.setString(3, vo.getCusHp());
			psmt.setInt(4, vo.getCusId());
			psmt.executeUpdate();
			close();
			
		}catch (Exception e) {
			e.printStackTrace();
		}
	}
	public void deleteCustomer (String CusName) {
		try {
			conn = getConnection();
			psmt = conn.prepareStatement("delete from `customer` where `CusName`=?");
			psmt.setString(1, CusName);
			psmt.executeUpdate();
			close();
		}catch (Exception e) {
			e.printStackTrace();
		}
	}

	
}
