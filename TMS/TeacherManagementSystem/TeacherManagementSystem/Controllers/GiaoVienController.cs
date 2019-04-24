using System;
using System.Collections.Generic;
using System.Web;
using System.Web.Mvc;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using TeacherManagementSystem.Models;

namespace TeacherManagementSystem.Controllers
{
	public class GiaoVienController : Controller
	{
		public string cn = ConfigurationManager.ConnectionStrings["Teacher"].ConnectionString;

		//GET: GiaoVien/Index
		public ActionResult Index()
		{
			List<TempTeacher> teachers = new List<TempTeacher>();
			using(var c = new SqlConnection(cn))
			{
				c.Open();
				var listGiaoVien = @"select MaGV, TenGiaoVien, QueQuan, GioiTinh, NgaySinh, TenKhoa, TenBoMon from 
										(
										select MaGV, GiaoVien.MaBoMon, TenGiaoVien, QueQuan, GioiTinh,NgaySinh, MaKhoa, TenBoMon from GiaoVien
											inner join BoMon
											on GiaoVien.MaBoMon = BoMon.MaBoMon
										) as GV_BM
									inner join DonVi
									on DonVi.MaKhoa = GV_BM.MaKhoa";
				SqlCommand sqlCommand = new SqlCommand(listGiaoVien, c);
				SqlDataReader reader = sqlCommand.ExecuteReader();
				if (reader.HasRows)
				{
					while (reader.Read())
					{
						//0 - mgv, 1 - TenGV, 2 - QueQuan, 3 - GioiTinh, 4 - NgaySinh, 5 - TenKhoa, 6 - TenBoMon
						var maGV = reader.GetInt32(0);
						var tenGV = reader.GetString(1);
						var queQuan = reader.GetString(2);
						var gioiTinh = reader.GetString(3);
						var ngaySinh = reader.GetDateTime(4).ToString("dd/MM/yyyy");
						var tenKhoa = reader.GetString(5);
						var tenBoMon = reader.GetString(6);
						var teacher = new TempTeacher() { MaGV = maGV, BoMon = tenBoMon, GioiTinh = gioiTinh, HoTen = tenGV, NgaySinh = ngaySinh, QueQuan = queQuan, DonVi = tenKhoa };
						teachers.Add(teacher);
					}
				}
				reader.Close();
				ViewBag.Teachers = teachers;
			}
			return View();
		}

		// GET: GiaoVien/Them
		public ActionResult Them()
		{
			TinhThanhPho tp = new TinhThanhPho();
			List<string> BoMon = new List<string>();
			//get max id
			using (var connection = new SqlConnection(cn))
			{
				connection.Open();
				//var getMaxTeacherId = "select IDENT_CURRENT('GiaoVien');";
				SqlCommand sqlCommand = new SqlCommand("SELECT IDENT_CURRENT ('GiaoVien')", connection);
				int maxId = Convert.ToInt32(sqlCommand.ExecuteScalar());
				var newMaxId = maxId;
				if(maxId != 1)
				{
					newMaxId = maxId + 1;
				}
				ViewBag.newId = newMaxId;
				connection.Close();
			}
			using (var connection = new SqlConnection(cn))
			{
				connection.Open();
				var TenKhoaQuery = "select TenBoMon from BoMon";
				SqlCommand sqlCommand = new SqlCommand(TenKhoaQuery, connection);
				SqlDataReader reader = sqlCommand.ExecuteReader();
				if (reader.HasRows)
				{
					while (reader.Read())
					{
						BoMon.Add(reader.GetString(0));
					}
				}
				reader.Close();
				ViewBag.BoMon = BoMon;
				
			}
			ViewBag.TinhThanhPho = tp.tinhThanhPho;
			return View();
		}
		public ActionResult Sua()
		{
			return View();
		}

		//POST: GiaoVien/Them
		[HttpPost]
		public ActionResult Them(FormCollection form)
		{
			using(var c = new SqlConnection(cn))
			{
				int idBoMon;
				var layIdBoMon = @"select MaBoMon from BoMon where TenBoMon = @bomon;";
				c.Open();
				using (SqlCommand sqlCommand = new SqlCommand(layIdBoMon, c))
				{
					sqlCommand.Parameters.AddWithValue("@bomon", form["bomon"]);
					idBoMon = (int)sqlCommand.ExecuteScalar();
				}
				var timeFormat = TeacherManagementSystem.Resource.sqlTimeFormat;

				var insertQuery = @"insert into GiaoVien(MaBoMon, TenGiaoVien, QueQuan, GioiTinh, NgaySinh) values (@MaBoMon, @TenGiaoVien, @QueQuan, @GioiTinh, @NgaySinh);";
				using(SqlCommand sqlCommand = new SqlCommand(insertQuery, c))
				{
					sqlCommand.Parameters.AddWithValue("@MaBoMon", idBoMon);
					sqlCommand.Parameters.AddWithValue("@TenGiaoVien", form["ten"]);
					sqlCommand.Parameters.AddWithValue("@QueQuan", form["quequan"]);
					sqlCommand.Parameters.AddWithValue("@GioiTinh", form["gioitinh"]);
					sqlCommand.Parameters.AddWithValue("@NgaySinh", form["ngaysinh"]);
					sqlCommand.ExecuteNonQuery();
				}
				return RedirectToAction("Index", "GiaoVien");
			}
		}
	}

	public class TempTeacher
	{
		public int MaGV { get; set; }
		public string HoTen { get; set; }
		public string QueQuan { get; set; }
		public string NgaySinh { get; set; }
		public string GioiTinh { get; set; }
		public string BoMon { get; set; }
		public string DonVi { get; set; }
	}
}