<%@page import="purchase.DemandNotice"%>
<%@ page import="purchase.Approve"%>
<%@ page language="java" import="java.util.*" contentType="text/html; charset=utf-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";

//未登录跳转
Object obj = session.getAttribute("userID");
String zhi_wei = (String)session.getAttribute("zhiwei");
if(obj == null||!("采购员".equals(zhi_wei))){
response.sendRedirect("login.jsp");
}
String userName = (String)session.getAttribute("userName") ;

%>
<jsp:useBean id="purchase" class="purchase.Purchase" scope="page"></jsp:useBean>
<%
	String userID = (String)session.getAttribute("userID") ;
	purchase.setUserID(userID) ;
	String demandID = request.getParameter("demandID") ;
 %>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>Purchase||Notice</title>
    
	
	<link rel="stylesheet" type="text/css" href="css/purchase.css">
	<link href="css/bootstrap.min.css" rel="stylesheet" type="text/css" >
	<script type="text/javascript" src="js/CookieUtil.js"></script>
	<script type="text/javascript" src="js/purchase-info.js"></script>
	<script type="text/javascript">
		var quit = function(){
			CookieUtil.unset("userID") ;
			CookieUtil.unset("password") ;
		}
	</script>
	<link rel="stylesheet" href="css/style.css" type="text/css" />
	<script src="js/jquery-1.3.min.js" type="text/javascript"></script>
	<script src="js/script.js" type="text/javascript"></script>
  </head>
  
  <body>
    <header id="header">
		<hgroup>
			<h1 class="site_title">Function</h1>
			<h2 class="section_title">Dashboard</h2>
			<div class="btn_help">
				<a href="">Help</a>
			</div>
		</hgroup>
	</header>
	<!--end of first header-->
	<section id="second_bar">
		<div class="user">
			<p><%=userName  %>（
				<a href=""><%=session.getAttribute("count") %>个未处理</a>
				）
			</p>
		</div>
		<div class="web_palce">
			<article class="place">
				<a   class="user_status" href="purchase-notice.jsp">采购部门</a>
				<div class="place_driver"></div>
				<a  href="purchase-notice.jsp">待办事项</a>
				<div class="place_driver"></div>
				<a  href="purchase-handle.jsp">需求单查看</a>	
				<div class="place_driver"></div>
				<a  class="current" href="#">采购填写</a>	
			</article>
		</div>
	</section>
	<!-- end second bar -->
	<aside id="side_bar">
		<div>
			<p id="alt">请选择</p>
			<hr>
		</div>
		<div class="function">
			<div id="notify"><a href="purchase-notice.jsp">待办事项</a></div>
			<div id="query"><a href="purchase-query.jsp">订单查看</a></div>
			<div id="support"><a href="purchase-support.jsp">供应商管理</a></div>
			<div id="exit" onclick="quit()"><a href="doQuit.jsp">退出登录</a></div>
		</div>
		<footer>
			<hr />
			<p>Copyright &copy; 2015 Silence</p>
			<p>Design by <a href="">Silence</a></p>
		</footer>
	</aside>
	<!-- end sidebar -->
	<section id="main">
		<div id = "main_div">
			<header class="notice">
			<h3>采购信息</h3>
			</header>
			<h4>你要采购的需求单：<%=demandID %></h4>
			<h4>当然用户ID号:<%=userID %></h4>
			<hr />

			<div class="form">
					<h3 align="center">
					请输入采购单的详细信息</h3>
					<hr />
					<form action="">
						<span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span>
						<label for="orderID">采购单ID&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</label>
						<input type="text" id="orderID" name="orderID" >
						<span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span>
						<label for="demandID">需求单ID&nbsp;&nbsp;</label>
						<input type="text" id="demandID" name="demandID" onchange="setInfo()">
						<br />
						<br />
						<span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span>
						<label for="itemID">需求物品ID&nbsp;&nbsp;</label>
						<input type="text" id="itemID" name="itemID" readonly="readonly">
						<span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span>
						<label for="number">数量&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</label>
						<input type="text" id="number" name="number" readonly="readonly">
						
						<br />
						<br />
						<span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span>
						<label for="account">总金额&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</label>
						<input type="text" id="account" name="account" readonly="readonly">
						<span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span>
						<label for="orderName">采购人&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</label>
						<input type="text" id="orderName" name="orderName" value=<%=userName %> readonly="readonly">
						
						<br />
						<br />

						<span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span>
						备注：
	  					<br />
						<br />
						<span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span>
						<textarea rows="8" cols="80%" id="extra" style="margin-left: 39px;"></textarea>
						<span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span>
						<br />
						<br />
						<span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span>
						<input type="submit">
						<span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span>
						<input type="reset" value="清空">
					</form>
				</div>
		</div>
		<div id="side_div1">
			<header id="time">
				<h3>时间</h3>
			</header>
			<table cellspacing="0">
			  <thead>
			    <tr>
			      <th>Mon</th>
			      <th>Tue</th>
			      <th>Wed</th>
			      <th>Thu</th>
			      <th>Fri</th>
			      <th>Sat</th>
			      <th>Sun</th>
			    </tr>
			  </thead>
			  <tbody>
			    <tr>
			      <td class="padding" colspan="3"></td>
			      <td> 1</td>
			      <td> 2</td>
			      <td> 3</td>
			      <td> 4</td>
			    </tr>
			    <tr>
			      <td> 5</td>
			      <td> 6</td>
			      <td> 7</td>
			      <td> 8</td>
			      <td class="today"> 9</td>
			      <td>10</td>
			      <td>11</td>
			    </tr>
			    <tr>
			      <td>12</td>
			      <td class="date_has_event"> 13
			        <div class="events">
			          <ul>
			            <li> <span class="title">Event 1</span> <span class="desc">Lorem ipsum dolor sit amet, consectetu adipisicing elit.</span> </li>
			            <li> <span class="title">Event 2</span> <span class="desc">Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.</span> </li>
			          </ul>
			        </div></td>
			      <td>14</td>
			      <td>15</td>
			      <td>16</td>
			      <td>17</td>
			      <td>18</td>
			    </tr>
			    <tr>
			      <td>19</td>
			      <td>20</td>
			      <td>21</td>
			      <td class="date_has_event"> 22
			        <div class="events">
			          <ul>
			            <li> <span class="title">Event 1</span> <span class="desc">Lorem ipsum dolor sit amet, consectetu adipisicing elit.</span> </li>
			            <li> <span class="title">Event 2</span> <span class="desc">Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.</span> </li>
			          </ul>
			        </div></td>
			      <td>23</td>
			      <td>24</td>
			      <td>25</td>
			    </tr>
			    <tr>
			      <td>26</td>
			      <td>27</td>
			      <td>28</td>
			      <td>29</td>
			      <td>30</td>
			      <td>31</td>
			      <td class="padding"></td>
			    </tr>
			  </tbody>
			</table>
		</div>

		<div id="side_div2">
			 <header id="curRecord">
			 	<h3>审批记录</h3>
			 </header>
			 	<table class="table table-striped table-hover table-bordered">
			 		<thead>
			 			<tr>
			 				<td>申请单号</td>
			 				<td>商品名称</td>
			 				<td>数量</td>
			 				<td>金额</td>
			 				<td>状态</td>
			 			</tr>
			 		</thead>
			 		
			 		<tbody>
			 				<%
						 		purchase.setApprove() ;
						 		ArrayList<Approve> approves = purchase.getApprove() ;
						 		Iterator<Approve> iterator = approves.iterator() ;
						 		
						 		while(iterator.hasNext()){
						 			out.print("<tr>") ;
						 			Approve approve = iterator.next() ;
						 			//out.println(approve.getRequestID()+","+approve.getItemName()+","+approve.getCount()+","+approve.getPrice()+","+approve.getStatus()) ;
						 			out.print("<td>"+approve.getRequestID()+"</td>");
						 			out.print("<td>"+approve.getItemName()+"</td>");
						 			out.print("<td>"+approve.getCount()+"</td>");
						 			out.print("<td>"+approve.getPrice()+"</td>");
						 			out.print("<td>"+approve.getStatus()+"</td>");
						 			out.print("</tr>") ;
						 		}
						 		
			 				 %>
			 		</tbody>
			 	</table>
		</div>
	</section>
  </body>
</html>