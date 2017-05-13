import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Types;
import java.util.Scanner;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;

import oracle.jdbc.OracleCallableStatement;
import oracle.jdbc.OracleDriver;
import oracle.jdbc.OracleTypes;

class HPMenu {
	
	static Connection con=null;
	static Scanner in=new Scanner(System.in);
	
	//constructor, establishing the db connection
	HPMenu() throws Exception{
	DriverManager.registerDriver(new OracleDriver());
		loop:while(con==null){
			try{
				//con=DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:xe","sys as sysdba","shiv1808");
				//con=DriverManager.getConnection("jdbc:oracle:thin:@//orca.csc.ncsu.edu:1521/orcl.csc.ncsu.edu","sbarai","200151447");
				//con=DriverManager.getConnection("jdbc:oracle:thin:@orca.csc.ncsu.edu:1521:orcl01","sbarai","200151447");
				con=DriverManager.getConnection("jdbc:oracle:thin:@orca.csc.ncsu.edu:1521:orcl01","apothug","200150507");
		     break loop;
			}
			catch(SQLException e){
				System.out.println("Trying again to establish connection...");
				continue loop;
			}	
		}
	
	
	}
	
	//main Menu
	void mainMenu() throws Exception {
		int action=0;
		for(;;)
		{
			System.out.println("*******************Personal Health Managment Portal*********************");
			System.out.println("1. Login as Patient");
			System.out.println("2. Login as Health Supporter");
			System.out.println("3. New User Registration");
			System.out.println("4. Exit");
			System.out.println("Enter the number for which you want to perform the action...");
			action=in.nextInt();
			switch(action){
			case 1: System.out.println("Login Patient");
				    loginPatient();
					break;
			case 2: System.out.println("Login Health Portal");
					loginHealthSupporter();
					break;
			case 3: System.out.println("New User Registration");
					newUserRegistration();
					break;
			case 4: System.out.println("*****************closed**************");
					con.close();
					System.exit(0);
					break;
			default: Runtime.getRuntime().exec("cls");
			         System.out.println("Wrong Choice");
					 break;
			}
		}
	}
	
	//Login functionality for patient
	void loginPatient() throws Exception{
		CallableStatement stmt=null;
		try
		{
			System.out.println("Please enter the user name");
			int username=in.nextInt();
			System.out.println("Please enter the password");
			String password=in.next();
			
		    stmt = con.prepareCall("BEGIN VALIDATE_LOGIN(?, ?, ?, ?); END;");
	        stmt.setInt(1,username);
	        stmt.setString(2, password);
	        stmt.setInt(3, 0);
	        stmt.registerOutParameter(4, OracleTypes.CURSOR); //REF CURSOR
	        stmt.execute();
	        ResultSet rs = ((OracleCallableStatement)stmt).getCursor(4);
	        //while (rs.next()) {
	        if(rs.next()){
	        	System.out.println("Welcome "+rs.getString("p_name")); 
	        	patientMenu(rs);
	        }
	        else{
	        	System.out.println(("please enter the correct details").toUpperCase());
	        	loginPatient();
	        }
	        
		}
		finally{
			if(stmt!=null){
				stmt.close();
			}
		}
	}
	
	//Login functionality for HealthSupporter
	void loginHealthSupporter() throws Exception{
		CallableStatement stmt=null;
		try
		{
			System.out.println("Please enter the user name");
			int username=in.nextInt();
			System.out.println("Please enter the password");
			String password=in.next();
			
		    stmt = con.prepareCall("BEGIN VALIDATE_LOGIN(?, ?, ?, ?); END;");
	        stmt.setInt(1,username);
	        stmt.setString(2, password);
	        stmt.setInt(3, 1);
	        stmt.registerOutParameter(4, OracleTypes.CURSOR); //REF CURSOR
	        stmt.execute();
	        ResultSet rs = ((OracleCallableStatement)stmt).getCursor(4);
	        //while (rs.next()) {
	        if(rs.next()){
	        	System.out.println("welcome "+rs.getString("p_name")); 
	        	healthSupporterMenu(rs);
	        	return ;
	        } 
	        else{
	        	System.out.println(("please enter the correct details").toUpperCase());
	        	loginHealthSupporter();
	        	return ;
	        }
	        
		}
		catch(Exception e){
        	System.out.println(("please enter the correct details.").toUpperCase());
        	loginHealthSupporter();
        }
		finally{
			if(stmt!=null){
				stmt.close();
			}
		}
	}
	//adding a new user
	void newUserRegistration() throws Exception{

			CallableStatement stmt=null;
		try
		{
			int insert=0;
			while(insert!=1)
			{
				System.out.println("Please enter the details to sign up");
				
				System.out.println("User ID:");
				int id=in.nextInt();
				System.out.println("Password:");
				String password=in.next();
				System.out.println("Name");
				String name=in.next();
				System.out.println("Date of Birth (DD-MMM-YYYY):");
				String dob=in.next();
				System.out.println("Gender (M/F):");
				String gender=in.next().toUpperCase();
				System.out.println("Address:");
				String address=in.next();
				System.out.println("Email id:");
				String email=in.next();
				System.out.println("Phone Number:");
				String phone=in.next();
				
			    stmt = con.prepareCall("BEGIN CREATE_USER(?, ?, ?, ?, ?, ?, ?, ?, ?); END;");
		        stmt.setInt(1,id);
		        stmt.setString(2, name);
		        stmt.setString(3, password);
		        stmt.setString(4, address);
		        stmt.setString(5, phone);
		        stmt.setString(6, gender);
		        stmt.setString(7, dob);
		        stmt.setString(8, email);
		        stmt.registerOutParameter(9,Types.NUMERIC);
		        stmt.execute();
		        int result=stmt.getInt(9);
		        if(result==1)
		        {
		        	System.out.println("Successfully Registered");
		        	insert=1;
		        	mainMenu();
		        	return ;
		        }
			}
		}
		catch(SQLException e){
			
			System.out.println(("Please enter the details correctly...." + e).toUpperCase());
			newUserRegistration();
		}	
	}
	
	//Patient Menu
	void patientMenu(ResultSet rs) throws Exception {
		int action=0;
		for(;;)
		{
			System.out.println("*******************Patient Actions*********************");
			System.out.println("1. View Profile");
			System.out.println("2. Update Account Details");
			System.out.println("3. View diseases");
			System.out.println("4. Add diseases");
			System.out.println("5. Delete diseases");
			System.out.println("6. View Observations");
			System.out.println("7. Add Observations");
			System.out.println("8. Update Observations");
			System.out.println("9. View Health Supporters");
			System.out.println("10. Add Health Supporters");
			System.out.println("11. Update Health Supporters");
			System.out.println("12. Delete Health Supporters");
			System.out.println("13. View Alerts");
			System.out.println("14. View Recommendations");
			System.out.println("0. LogOut");
			System.out.println("Enter the number for which you want to perform the action...");
			action=in.nextInt();
			switch(action){
			case 1: System.out.println("1.View Profile");
					int isPatient=1;
					int fromHSMenu=0;
					viewProfile(rs,rs.getInt("pid"),isPatient,fromHSMenu);
					break;
			case 2: System.out.println("2.Updating Account Details");
					int isPatient1=1;
					int fromHSMenu1=0;
					updatePatientDetails(rs,rs.getInt("pid"),isPatient1,fromHSMenu1);
					break;
			case 3: System.out.println("3. View diseases");
					viewDisease(rs);
					break;
			case 4: System.out.println("4. Add diseases");
					addDisease(rs);
					break;
			case 5: System.out.println("5. Delete diseases");
					deleteDisease(rs);
					break;
			case 6: System.out.println("6. View Observations");
					viewObservations(rs);
					break;
			case 7: System.out.println("7. Add Observations");
					addObservations(rs);
					break;
			case 8: System.out.println("8. Update Observations");
					updateObservations(rs);
					break;
			case 9: System.out.println("9. View Health Supporters");
					viewpHealthSupporters(rs);
					break;
			case 10: System.out.println("10. Add Health Supporters");
					addpHealthSupporters(rs);
					break;
			case 11: System.out.println("11. Update Health Supporters");
					 updatepHealthSupporters(rs);
					break;
			case 12: System.out.println("12. Delete Health Supporters");
					deletepHealthSupporters(rs);
					break;
			case 13: System.out.println("13. View Alerts");
					 int isPatient2=1;
					viewAlerts(rs,rs.getInt("pid"),isPatient2);
					break;
			case 14: System.out.println("14. View Recommendations");
					int isPatient3=1;
					viewRecommendations(rs,rs.getInt("pid"),isPatient3);
			case 0: System.out.println("0. LogOut");
					rs.close();
					rs=null;
					mainMenu();
					return ;
			/*case 6: System.out.println("*****************closed**************");
					System.exit(0);
					break;*/
			default: Runtime.getRuntime().exec("cls");
			         System.out.println("Wrong Choice");
					 break;
			}
		}
	}
	
	//view profile
	void viewProfile(ResultSet rs, int pid,int isPatient, int fromHSMenu)throws Exception{
		System.out.println("*******************View Profile*********************");
		CallableStatement stmt=null;
		CallableStatement stmt1=null;
		try
		{
			stmt1 = con.prepareCall("BEGIN GET_PERSON_INFO(?, ?); END;");
	        stmt1.setInt(1,pid);
	        stmt1.registerOutParameter(2, OracleTypes.CURSOR); //REF CURSOR
	        stmt1.execute();
	        ResultSet rs1 = ((OracleCallableStatement)stmt1).getCursor(2);
	        if(rs1.next()){
	        	
	        	System.out.println("User ID: "+pid);
		        System.out.println("User Name: "+rs1.getString("p_name"));
		        if(isPatient!=0){
		        	System.out.println("Password: "+rs1.getString("p_password"));
		        }
		        
		        System.out.println("Date of Birth: "+rs1.getDate("dob"));
		        System.out.println("Gender: "+rs1.getString("gender"));
		        System.out.println("Address: "+rs1.getString("address"));
		        System.out.println("Email: "+rs1.getString("email"));
		        System.out.println("Phone: "+rs1.getInt("phone"));
		        if(isPatient==1 && fromHSMenu==0){
		        	stmt = con.prepareCall("BEGIN IS_WELL_OR_SICK(?, ?); END;");
			        stmt.setInt(1,rs1.getInt("pid"));
			        stmt.registerOutParameter(2, Types.NUMERIC); //REF CURSOR
			        stmt.execute();
			        int isSick=stmt.getInt(2);
		        	if(isSick==1){
			        	System.out.println("Patient Category: Sick");
			        }
			        else{
			        	System.out.println("Patient Category: Well");
			        }
		        }     
	        }    
		}
		catch(Exception e){
			System.out.println(("Error while fetching the profile details "+e).toUpperCase());
		}
		finally{
				stmt.close();
				stmt1.close();
				if(isPatient==1){
					if(fromHSMenu==0){
						patientMenu(rs);
					}
					
					else{
						healthSupporterMenu(rs);
					}
				}
				else
				{
						healthSupporter_Patients(rs);
				}
				
			}
	}
	
	//update the patient details
	void updatePatientDetails(ResultSet rs,int pid,int isPatient,int fromHSMenu)throws Exception{

		CallableStatement stmt=null;
		try
		{
			int insert=0;
			while(insert!=1)
			{
				System.out.println("*******************Update Patient Details*********************");
				System.out.println("0. IF DONE WITH UPDATING");
				System.out.println("1. User Name");
				System.out.println("2. Password");
				System.out.println("3. Address");
				System.out.println("4. Phone");
				System.out.println("5. Gender");
				System.out.println("6. Date of Birth");
				System.out.println("7. Email");
				
				System.out.println("Enter the number for which you want to update the information...");
				int action1=0;
				String[] newdetails={"","","","","","",""};
				int[] flag={0,0,0,0,0,0,0};
				outer:for(;;)
				{
					
					action1=in.nextInt();
					switch(action1){
					case 1:if(isPatient==1)
							{
								if(flag[0]==0)
								{
									System.out.println("Enter new User Name");
									newdetails[0]=in.next();
									flag[0]=1;
								}
								else
								{
									System.out.println("New User Name has already been entered");
								}
							}
							else{
								System.out.println("Health Supporter is not allowed to update this information");
							}
							break;
					case 2: if(isPatient==1)
							{
								if(flag[1]==0)
								{
									System.out.println("Enter new Password");
									newdetails[1]=in.next();
									flag[1]=1;
								}
								else
								{
									System.out.println("New password has already been entered");
								}
							}
							else
							{
								System.out.println("Health Supporter is not allowed to update this information");
							}	
							break;
					case 3: if(isPatient==1)
							{
								if(flag[2]==0)
								{
									System.out.println("Enter new Address");
									newdetails[2]=in.next();
									flag[2]=1;
								}
								else
								{
									System.out.println("New Address has already been entered");
								}
							}
							else
							{
								System.out.println("Health Supporter is not allowed to update this information");
							}
							break;
					case 4: if(flag[3]==0)
							{
								System.out.println("Enter New Phone Number");
								newdetails[3]=in.next();
								flag[3]=1;
							}
							else{
								System.out.println("New Phone has already been entered");
							}
							break;
					case 5: if(isPatient==1)
							{
								if(flag[4]==0)
								{
									System.out.println("Update Gender: (M/F)");
									newdetails[4]=in.next();
									flag[4]=1;
								}
								else{
									System.out.println("Gender Input has already been entered");
								}
							}
							else
							{
								System.out.println("Health Supporter is not allowed to update this information");
							}
							break;
					case 6: if(isPatient==1)
							{
								if(flag[5]==0)
								{
									System.out.println("Enter the correct Date of birth:(DD-MMM-YYYY)");
									newdetails[5]=in.next();
									flag[5]=1;
								}
								else{
									System.out.println("Date of birth input has already been provided");
								}
							}
							else
							{
								System.out.println("Health Supporter is not allowed to update this information");
							}
							break;
					case 7: if(flag[6]==0)
							{
								System.out.println("Enter the new Email ID");
								newdetails[6]=in.next();
								flag[6]=1;
							}
							else{
								System.out.println("New Email ID has already been provided");
							}
							break;
					case 0: break outer;
					/*case 6: System.out.println("*****************closed**************");
							System.exit(0);
							break;*/
					default: Runtime.getRuntime().exec("cls");
							 System.out.println("Wrong Choice");
							 break;
					}
				}
				
				
				stmt = con.prepareCall("BEGIN UPDATE_USER(?, ?, ?, ?, ?, ?, ?, ?, ?); END;");
				stmt.setInt(1,pid);
				stmt.setString(2, flag[0]==1?newdetails[0]:rs.getString("p_name"));
				stmt.setString(3, flag[1]==1?newdetails[1]:rs.getString("p_password"));
				stmt.setString(4, flag[2]==1?newdetails[2]:rs.getString("address"));
				stmt.setString(5, flag[3]==1?newdetails[3]:rs.getString("phone"));
				stmt.setString(6, flag[4]==1?newdetails[4]:rs.getString("gender"));
				stmt.setDate(7, flag[5]==1?(java.sql.Date) converttodate(newdetails[5]):rs.getDate("dob"));
				stmt.setString(8, flag[6]==1?newdetails[6]:rs.getString("email"));
				stmt.registerOutParameter(9,Types.NUMERIC);
				stmt.execute();
				int result=stmt.getInt(9);
				if(result==1)
				{
					System.out.println("Successfully Updated the User Details");
					insert=1;
					if(isPatient==1){
						if(fromHSMenu==0){
							patientMenu(rs);
						}
						
						else{
							healthSupporterMenu(rs);
						}
					}
					else
					{
							healthSupporter_Patients(rs);
					}
					return ;
				}
			}
		}
		catch(SQLException e){
			
			System.out.println(("Please enter the details correctly...." + e).toUpperCase());
			updatePatientDetails(rs,pid,isPatient,fromHSMenu);
		}
		finally{
			stmt.close();
		}
        
	}
	
	//view diseases of patient
	void viewDisease(ResultSet rs)throws Exception{
		System.out.println("*******************View Disease*********************");
		CallableStatement stmt=null;
		ResultSet rs1 =null;
		try
		{
		    stmt = con.prepareCall("BEGIN GET_DISEASE_FOR_PATIENT(?, ?); END;");
	        stmt.setInt(1,rs.getInt("pid"));
	        stmt.registerOutParameter(2, OracleTypes.CURSOR); //REF CURSOR
	        stmt.execute();
	        rs1 = ((OracleCallableStatement)stmt).getCursor(2);
	        if(rs1.next()){
	        	System.out.println("Here is the list of the diseases, "+rs.getString("p_name"));
	        	System.out.println("*************************************************");
	        	System.out.println("Disease ID\tDisease Name");
	        	do{
	        		System.out.println(rs1.getString("did")+"\t\t"+rs1.getString("dname"));
	        	}while(rs1.next());
	        	System.out.println("*************************************************");
	        }
	        else{
	        	System.out.println(("You currently don't have any diseases to check").toUpperCase());
	        }
	        
		}
		catch(Exception e){
			System.out.println(("Error while fetching the details of Diseases "+e).toUpperCase());
		}
		finally{
				stmt.close();
				rs1.close();
				patientMenu(rs);
				
			}
		}
		
	//add diseases for patients
	void addDisease(ResultSet rs) throws Exception{
		CallableStatement stmt=null;
		try
		{
			System.out.println("*******************Add Disease*********************");
			System.out.println("Enter the input in format: <Disease_no>");
			int diseaseNo = in.nextInt();
			
			stmt = con.prepareCall("BEGIN ADD_DISEASE(?, ?, ?); END;");
			stmt.setInt(1,rs.getInt("pid"));
			stmt.setInt(2, diseaseNo);
			stmt.registerOutParameter(3,Types.NUMERIC);
			stmt.execute();
			int result=stmt.getInt(3);
			if(result==1)
			{
				System.out.println("Successfully added the Disease");
			} else {
				System.out.println(("Add health supporter before you insert a disease.").toUpperCase());
			}
		} catch (Exception ex){
			System.out.println(("Unexpected error while adding disease"+ex).toUpperCase());
		} finally{
			stmt.close();
			patientMenu(rs);
		}
	}
	
	//delete diseases for patients
	void deleteDisease(ResultSet rs)throws Exception{
		CallableStatement stmt=null;
		try
		{
			System.out.println("*******************Delete Disease*********************");
			System.out.println("Enter the Disease id to delete: <Disease_no>");
			int diseaseNo = in.nextInt();
			
			stmt = con.prepareCall("BEGIN DELETE_DISEASE(?, ?, ?); END;");
			stmt.setInt(1,rs.getInt("pid"));
			stmt.setInt(2, diseaseNo);
			stmt.registerOutParameter(3,Types.NUMERIC);
			stmt.execute();
			int result=stmt.getInt(3);
			if(result==1)
			{
				System.out.println("Successfully Deleted the Disease");
			}
			else
			{
				System.out.println("Unable to delete the Disease entry");
			}
		} catch (Exception ex){
			System.out.println(("Unexpected error while deleting disease"+ex).toUpperCase());
		} finally{
			stmt.close();
			patientMenu(rs);
		}
	}
	
	//view observations
	void viewObservations(ResultSet rs)throws Exception{
		System.out.println("*******************View Observations*********************");
		CallableStatement stmt=null;
		ResultSet rs1 =null;
		try
		{
		    stmt = con.prepareCall("BEGIN GET_OBSERVATIONS_FOR_PATIENT(?, ?); END;");
	        stmt.setInt(1,rs.getInt("pid"));
	        stmt.registerOutParameter(2, OracleTypes.CURSOR); //REF CURSOR
	        stmt.execute();
	        rs1 = ((OracleCallableStatement)stmt).getCursor(2);
	        if(rs1.next()){
	        	System.out.println("Here is the list of the observations, "+rs.getString("p_name"));
	        	System.out.println("*************************************************");
	        	System.out.println("Observation ID\tObservation Time\tRecording Time\tHealth Indicator\tObservation Value");
	        	do{
	        		System.out.println(rs1.getString("OBSERVATION_ID")+"\t"+rs1.getDate("OBSERVATION_TIME").toString()+"\t"+rs1.getDate("RECORDED_DATE").toString()+"\t"+rs1.getString("PARAM_NAME")+"\t"+rs1.getString("OBSERVATION_VALUE"));
	        	}while(rs1.next());
	        	System.out.println("*************************************************");
	        }
	        else{
	        	System.out.println(("You currently don't have any observations").toUpperCase());
	        }
	        
		}
		catch(Exception e){
			System.out.println(("Error while fetching the observations "+e).toUpperCase());
		}
		finally{
				stmt.close();
				rs1.close();
				patientMenu(rs);
				
			}
	}
	
	//add observations
	void addObservations(ResultSet rs)throws Exception{
		CallableStatement stmt=null;
		try
		{
			System.out.println("*******************Add Observations*********************");
			System.out.println("Enter the Observation ID");
			int observationID = in.nextInt();
			System.out.println("Enter the Health ID:");
			int HID = in.nextInt();
			System.out.println("Enter the Health Indicator Type:");
			String htype=in.next();
			System.out.println("Enter the Observation Value");
			String observationValue=in.next();
			System.out.println("Enter the Observation Time:(DD-MMM-YYYY)");
			String observationTime=in.next();
			
			stmt = con.prepareCall("BEGIN ADD_OBSERVATION(?, ?, ?, ?, ?, ?, ?); END;");
			stmt.setInt(1,observationID);
			stmt.setInt(2, rs.getInt("pid"));
			stmt.setInt(3, HID);
			stmt.setString(4, htype);
			stmt.setString(5, observationValue);
			stmt.setString(6, observationTime);
			
			stmt.registerOutParameter(7,Types.NUMERIC);
			stmt.execute();
			int result=stmt.getInt(7);
			if(result==1)
			{
				System.out.println("Successfully added the Observation");
			} 
			else{
				System.out.println("Unable to add observation.");
			}
		} catch (Exception ex){
			System.out.println(("Unexpected error while adding observations. Make sure you provide the data correct format. unique observation id. "+ex).toUpperCase());
		} finally{
			stmt.close();
			patientMenu(rs);
		}
	}
	
	//update observations
	void updateObservations(ResultSet rs)throws Exception{
		CallableStatement stmt=null;
		try
		{	
			System.out.println("*******************Update Observations*********************");
			System.out.println("Enter the Observation ID for which you want to update");
			int observationID = in.nextInt();
			System.out.println("Enter the New Observation Value");
			String observationValue=in.next();
			System.out.println("Enter the New Observation Time:(DD-MMM-YYYY)");
			String observationTime=in.next();
			
			stmt = con.prepareCall("BEGIN UPDATE_OBSERVATION(?, ?, ?, ?); END;");
			stmt.setInt(1,observationID);
			stmt.setString(2, observationValue);
			stmt.setString(3, observationTime);
			
			stmt.registerOutParameter(4,Types.NUMERIC);
			stmt.execute();
			int result=stmt.getInt(4);
			if(result==1)
			{
				System.out.println("Successfully updated the Observation Value");
			} 
			else{
				System.out.println("Unable update the Observation Value");
			}
			
		} catch (Exception ex){
			System.out.println(("Unexpected error while updating observations. Make sure you provide the data correct format. correct observation id. "+ex).toUpperCase());
		} finally{
			stmt.close();
			patientMenu(rs);
		}
	}
	
	//view Health Supporters
	void viewpHealthSupporters(ResultSet rs)throws Exception{
		System.out.println("*******************View Health Supporters*********************");
		CallableStatement stmt=null;
		ResultSet rs1 =null;
		try
		{
		    stmt = con.prepareCall("BEGIN VIEW_HEALTH_SUPPORTERS(?, ?); END;");
	        stmt.setInt(1,rs.getInt("pid"));
	        stmt.registerOutParameter(2, OracleTypes.CURSOR); //REF CURSOR
	        stmt.execute();
	        rs1 = ((OracleCallableStatement)stmt).getCursor(2);
	        if(rs1.next()){
	        	System.out.println("Here is the list of the Health Supporters");
	        	System.out.println("*************************************************");
	        	System.out.println("Health ID\tHealth Supporter type\tAuthorised Date");
	        	do{
	        		System.out.println(rs1.getInt("HS_PID")+"\t"+rs1.getString("HS_TYPE")+"\t"+rs1.getDate("AUTH_DATE").toString());
	        	}while(rs1.next());
	        	System.out.println("*************************************************");
	        }
	        else{
	        	System.out.println(("You currently don't have any Health Supporters").toUpperCase());
	        }
	        
		}
		catch(Exception e){
			System.out.println(("Error while fetching the details of Health Supporters"+e).toUpperCase());
		}
		finally{
				stmt.close();
				rs1.close();
				patientMenu(rs);
				
			}
		
	}
	
	//add Health Supporters
	void addpHealthSupporters(ResultSet rs)throws Exception{
		CallableStatement stmt=null;
		try
		{
			System.out.println("*******************Add Health Supporters*********************");
			System.out.println("Enter the Health Supporter ID to add");
			int HSID = in.nextInt();
			System.out.println("Enter the Authorization Date:(DD-MMM-YYYY)");
			String aDate=in.next();
			
			stmt = con.prepareCall("BEGIN ADD_HEALTH_SUPPORTERS(?, ?, ?, ?); END;");
			stmt.setInt(1,rs.getInt("pid"));
			stmt.setInt(2, HSID);
			stmt.setString(3, aDate);
			stmt.registerOutParameter(4,Types.NUMERIC);
			stmt.execute();
			int result=stmt.getInt(4);
			System.out.println(result);
			if(result==1)
			{
				System.out.println("Successfully added the Health Supporter");
			} 
			else{
				System.out.println("Unable to add Health Supporters.");
			}
		} catch (Exception ex){
			System.out.println(("Unexpected error while adding Health Supporter"+ex).toUpperCase());
		} finally{
			stmt.close();
			patientMenu(rs);
		}
	}
	
	//update Health Supporters
	void updatepHealthSupporters(ResultSet rs)throws Exception{
		CallableStatement stmt=null;
		try
		{	
			System.out.println("*******************Update Health Supporters*********************");
			System.out.println("Enter the Health Supporter ID for which you want to update");
			int supporterID = in.nextInt();
			System.out.println("Enter the New Authorization Date");
			String adate=in.next();
			System.out.println("Enter the Supporter Type:(PRIMARY/SECONDARY):");
			String supporterType=in.next();
			
			stmt = con.prepareCall("BEGIN UPDATE_HEALTH_SUPPORTERS(?, ?, ?, ?, ?); END;");
			stmt.setInt(1,rs.getInt("pid"));
			stmt.setInt(2, supporterID);
			stmt.setString(3, adate);
			stmt.setString(4, supporterType);
			
			stmt.registerOutParameter(5,Types.NUMERIC);
			stmt.execute();
			int result=stmt.getInt(5);
			if(result==1)
			{
				System.out.println("Successfully updated the Health Supporters Data");
			} 
			else
			{
				System.out.println("Unable to update the Health Supporters Data");
			}
			
		} catch (Exception ex){
			System.out.println(("Unexpected error while adding observations. Make sure you provide the data correct format. correct observation id. "+ex).toUpperCase());
		} finally{
			stmt.close();
			patientMenu(rs);
		}
	}
	
	//Delete Health Supporters
	void deletepHealthSupporters(ResultSet rs)throws Exception{
		CallableStatement stmt=null;
		try
		{
			System.out.println("*******************Delete HealthSupporters*********************");
			System.out.println("Enter the Health Supporter id to delete: <Disease_no>");
			int HSId = in.nextInt();
			
			stmt = con.prepareCall("BEGIN DELETE_HEALTH_SUPPORTERS(?, ?, ?); END;");
			stmt.setInt(1,rs.getInt("pid"));
			stmt.setInt(2, HSId);
			stmt.registerOutParameter(3,Types.NUMERIC);
			stmt.execute();
			int result=stmt.getInt(3);
			if(result==1)
			{
				System.out.println("Successfully Deleted the Health Supporter");
			}
			else{
				System.out.println("Unable to delete the Health Supporter");
			}
		} catch (Exception ex){
			System.out.println(("Unexpected error while deleting Health Supporter"+ex).toUpperCase());
		} finally{
			stmt.close();
			patientMenu(rs);
		}
	}
	
	//view alerts
	void viewAlerts(ResultSet rs,int pid,int isPatient)throws Exception{
		System.out.println("*******************View Alerts*********************");
		CallableStatement stmt=null;
		ResultSet rs1 =null;
		try
		{
		    stmt = con.prepareCall("BEGIN VIEW_ALERTS(?, ?); END;");
	        stmt.setInt(1,pid);
	        stmt.registerOutParameter(2, OracleTypes.CURSOR); //REF CURSOR
	        stmt.execute();
	        rs1 = ((OracleCallableStatement)stmt).getCursor(2);
	        if(rs1.next()){
	        	//System.out.println("Here are the alerts, "+rs.getString("p_name"));
	        	//System.out.println("*************************************************");
	        	//System.out.println("Alert ID\tAlert Type\tHID");
	        	System.out.println("Alert Type\tHealth Indicator\tMessage");
	        	do{
	        		//System.out.println(rs1.getString("aid")+"\t"+rs1.getString("alert_type")+"\t"+rs1.getString("hid"));
	        		if(rs1.getString("message")!=null){
	        			System.out.println(rs1.getString("alert_type")+"\t"+getHealthIndicatorName(rs1.getString("hid"))+"\t\t\t"+rs1.getString("message"));
	        		}
	        		else{
	        			System.out.println(rs1.getString("alert_type")+"\t"+getHealthIndicatorName(rs1.getString("hid")));
	        		}
	        		
	        	}while(rs1.next());
	        	System.out.println("*************************************************");
	        }
	        else{
	        	System.out.println(("You currently don't have any alerts to view").toUpperCase());
	        }
	        
		}
		catch(Exception e){
			System.out.println(("Error while fetching the alerts "+e).toUpperCase());
		}
		finally{
				stmt.close();
				rs1.close();
				if(isPatient==1){
					patientMenu(rs);
				}
				else{
					healthSupporterMenu(rs);
				}
				
			}
	}
	
	//HealthSupporter Menu
	void healthSupporterMenu(ResultSet rs) throws Exception{
		int action=0;
		for(;;)
		{
			System.out.println("*******************Patient Actions*********************");
			System.out.println("1. View Profile");
			System.out.println("2. Update Account Details");
			System.out.println("3. View Alerts");
			System.out.println("4. Patient Profiles");
			System.out.println("0. LogOut");
			System.out.println("Enter the number for which you want to perform the action...");
			action=in.nextInt();
			switch(action){
			case 1: System.out.println("1.View Profile");
					int isPatient1=1;
					int fromHSMenu1=1;
					viewProfile(rs,rs.getInt("pid"),isPatient1,fromHSMenu1);
					break;
			case 2: System.out.println("2.Updating Account Details");
					int isPatient2=1;
					int fromHSMenu2=1;
					updatePatientDetails(rs,rs.getInt("pid"),isPatient2,fromHSMenu2);
					break;
			case 3: System.out.println("3. View Alerts");
					int isPatient3=0;
					viewAlerts(rs,rs.getInt("pid"),isPatient3);
					break;
			case 4: System.out.println("4. Patient Profiles");
					healthSupporter_Patients(rs);
					break;
			case 0: System.out.println("0. LogOut");
					rs.close();
					rs=null;
					mainMenu();
					return ;
			/*case 6: System.out.println("*****************closed**************");
					System.exit(0);
					break;*/
			default: Runtime.getRuntime().exec("cls");
			         System.out.println("Wrong Choice");
					 break;
			}
		}
		
	}
	
	//healthsupporter actions for patients
	void healthSupporter_Patients(ResultSet rs)throws Exception{
		int action=0;
		ArrayList<Integer> pids= getPatientsID(rs);
		System.out.println("List of Patients under you:");
		for(Integer a:pids){
			System.out.print(a+"\t");
		}
		System.out.println();
			System.out.println("Give the patient id of the patients context that you want view or update");
			int pid=in.nextInt();
			if(pids.contains(pid))
			{
				for(;;)
				{
					System.out.println("*******************Health Supporter Actions on Patients*********************");
					System.out.println("1. View Specific Recommendations");
					System.out.println("2. Override Recommendations");
					System.out.println("3. View Patient Proifle");
					System.out.println("4. Update Patient Details");
					System.out.println("5. Switch to other user");
					System.out.println("0. Go back to Health Supporter Menu");
					//System.out.println("6. Add Specific Recommendations");
					System.out.println("Enter the number for which you want to perform the action...");
					action=in.nextInt();
					switch(action){
					case 1: System.out.println("1. View Specific Recommendations");
							int isPatient3=0;
							viewRecommendations(rs,pid,isPatient3);
							break;
					case 2: System.out.println("2. Override Recommendations");
							updateRecommendations(rs,pid);
							break;
					case 3: System.out.println("3. View Patient Profile");
							int isPatient1=0;
							int fromHSMenu1=0;
							viewProfile(rs,pid,isPatient1,fromHSMenu1);
							break;
					case 4: System.out.println("4. Update Patient Detials");
							int isPatient2=0;
							int fromHSMenu2=0;
							updatePatientDetails(rs,pid,isPatient2,fromHSMenu2);
							break;	
					case 5: System.out.println("4. Switch to other user");
							healthSupporter_Patients(rs);
							break;
					case 0: System.out.println("0. Go back to Health Supporter Menu");
							healthSupporterMenu(rs);
							break;
//					case 5: System.out.println("3. Add Specific Recommendations");
//							addRecommendations(rs,pid);
//							break;
//					case 0: System.out.println("0. LogOut");
//							rs.close();
//							rs=null;
//							mainMenu();
//							return ;
					default: Runtime.getRuntime().exec("cls");
					         System.out.println("Wrong Choice");
							 break;
					}
				}			
			}
			else{
				System.out.println("Enter the correct patient id to view the patient details");
				healthSupporter_Patients(rs);
			}
		
	}
	
	//view recommendations specific to patients
	void viewRecommendations(ResultSet rs,int pid,int isPatient)throws Exception{
		System.out.println("*******************View Recommendations*********************");
		CallableStatement stmt=null;
		ResultSet rs1 =null;
		ResultSet rs2 =null;
		try
		{
		    //stmt = con.prepareCall("BEGIN VIEW_RECOMMENDATIONS_HS(?, ?, ?); END;");
			stmt = con.prepareCall("BEGIN VIEW_RECOMMENDATIONS_HS(?, ?, ?); END;");
	        stmt.setInt(1,pid);
	        stmt.registerOutParameter(2, OracleTypes.CURSOR);//REF CURSOR
	        stmt.registerOutParameter(3, OracleTypes.CURSOR);//REF CURSOR
	        stmt.execute();
	        rs1 = ((OracleCallableStatement)stmt).getCursor(2);
	        rs2 = ((OracleCallableStatement)stmt).getCursor(3);
	        boolean first=rs1.next();
	        boolean second=rs2.next();
	        if(first||second){
	        	if(first){
		        	//System.out.println("Here is the list of Recommendations for: "+rs1.getString("p_name"));
		        	System.out.println("*************************************************");
		        	System.out.println("HID\tHealth Type\tMin Value\tMax Value");
		        	do{
		        		System.out.println(rs1.getInt("hid")+"\t"+rs1.getString("param_name")+"\t\t"+rs1.getInt("min_value")+"\t"+rs1.getInt("max_value"));
		        	}while(rs1.next());	
		        }
		        if(second){
		        	do{
		        		System.out.println(rs2.getInt("hid")+"\t"+rs2.getString("param_name")+"\t"+rs2.getString("enum"));
		        	}while(rs2.next());
		        	System.out.println("*************************************************");
		        }
	        }
	        else{
	        	System.out.println(("You currently don't have any Recommendations to view for this profile").toUpperCase());
	        }
	        
		}
		catch(Exception e){
			System.out.println(("Error while fetching the Recommendations "+e).toUpperCase());
		}
		finally{
				stmt.close();
				rs1.close();
				if(rs2 != null)
					rs2.close();
				if(isPatient==0){
					healthSupporter_Patients(rs);
				}
				else{
					patientMenu(rs);
				}	
			}
	}
	
	
	//add recommendations specific to patients
//	void addRecommendations(ResultSet rs,int pid)throws Exception{
//		CallableStatement stmt=null;
//		try
//		{
//			System.out.println("*******************Add Recommendations*********************");
//			System.out.println("Enter the input in format: <Disease_no>");
//			int diseaseNo = in.nextInt();
//			
//			stmt = con.prepareCall("BEGIN ADD_RECOMMENDATIONS(?, ?, ?); END;");
//			stmt.setInt(1,pid);
//			stmt.setInt(2, diseaseNo);
//			stmt.registerOutParameter(3,Types.NUMERIC);
//			stmt.execute();
//			int result=stmt.getInt(3);
//			if(result==1)
//			{
//				System.out.println("Successfully added the Recommendations");
//			} 
//	else{
//		System.out.println("Unable to add Recommendations");
//	}
//		} catch (Exception ex){
//			System.out.println(("Unexpected error while adding Recommendations"+ex).toUpperCase());
//		} finally{
//			stmt.close();
//			healthSupporter_Patients(rs);
//		}
//	}
	
	// update the recommendations specific to patients
	void updateRecommendations(ResultSet rs,int pid)throws Exception{
		CallableStatement stmt=null;
		try
		{	
			System.out.println("*******************Update Recommendations*********************");
			System.out.println("Enter the Health ID for which you want to update");
			int HealthID = in.nextInt();
			System.out.println("Enter the Health Type");
			String HealthType=in.next();
			System.out.println("Enter the minimum value");
			int min=in.nextInt();
			System.out.println("Enter the maximum value");
			int max=in.nextInt();
			System.out.println("Enter the value for enum");
			String en=in.next();
			
			stmt = con.prepareCall("BEGIN UPDATE_RECOMMENDATIONS(?, ?, ?, ?, ?, ?, ?); END;");
			stmt.setInt(1, pid);
			stmt.setInt(2, HealthID);
			stmt.setString(3,HealthType);
			stmt.setInt(4, min);
			stmt.setInt(5,max);
			stmt.setString(6,en);
			stmt.registerOutParameter(7,Types.NUMERIC);
			stmt.execute();
			int result=stmt.getInt(7);
			if(result==1)
			{
				System.out.println("Successfully updated the Recommendations");
			} 
			else{
				System.out.println("Unable to update the Recommendations");
			}
			
		} catch (Exception ex){
			System.out.println(("Unexpected error while updating Recommendations. Make sure you provide the data correct format. correct Recommendations id. "+ex).toUpperCase());
		} finally{
			stmt.close();
			healthSupporter_Patients(rs);
		}
	}
	
	//To get the patient details for the current health  supporter
	ArrayList<Integer> getPatientsID(ResultSet rs) throws Exception{
		ArrayList<Integer> al=new ArrayList<Integer>();
		CallableStatement stmt=null;
		try{
			stmt = con.prepareCall("BEGIN GET_PATIENTS_OF_HS(?, ?); END;");
	        stmt.setInt(1,rs.getInt("pid"));
	        stmt.registerOutParameter(2, OracleTypes.CURSOR); //REF CURSOR
	        stmt.execute();
	        ResultSet rs1 = ((OracleCallableStatement)stmt).getCursor(2);
			while(rs1.next()){
				al.add(rs1.getInt("pid"));
			}
			return al;
		}
		finally{
			if(stmt!=null){
				stmt.close();
			}
		}
		
	}
	
	//utility to convert string date --java.util.date ---java.sql.date
	Date converttodate(String str){
		SimpleDateFormat formatter = new SimpleDateFormat("dd-MMM-yyyy");
        String dateInString = str;
        Date date=null;
        java.sql.Date sqlDate=null;
        try {

            date = formatter.parse(dateInString);
            //System.out.println(date);
            sqlDate = new java.sql.Date(date.getTime());
            formatter.format(sqlDate);
            //System.out.println(sqlDate);
            
        } catch (ParseException e) {
            e.printStackTrace();
        }
        return sqlDate;
	}
	
	
	//utility to get health indicator name provided hid
	static String getHealthIndicatorName(String hid) throws SQLException{
		CallableStatement stmt=null;
		try{
			stmt = con.prepareCall("BEGIN GET_HI_NAME(?, ?); END;");
			int hid1=Integer.parseInt(hid);
	        stmt.setInt(1,hid1);
	        stmt.registerOutParameter(2, Types.VARCHAR); //REF CURSOR
	        stmt.execute();
	        String hName=stmt.getString(2);
	        return hName;
		}
		finally{
			if(stmt!=null){
				stmt.close();
			}
		}
	}
};
public class HPM {

	public static void main(String[] args) throws Exception {
		HPMenu hpmenu=new HPMenu();
		hpmenu.mainMenu();
	}

}
