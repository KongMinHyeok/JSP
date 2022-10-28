package config;

public class sql {

	public static final String SELECT_CUSTOMER = "SELECT * FROM  `customer`";
	
	public static final String SELECT_ORDER = "SELECT `orderNo`, c.`name`, b.`proName`, `ordercount`, `orderdate` FROM `order` AS a "
											+ "JOIN `product` AS b on a.orderProduct = b.prodno "
											+ "JOIN `customer` AS c on a.orderId = c.custld";
	
	public static final String SELECT_PRODUCT = "SELECT * FROM `product`";

}
