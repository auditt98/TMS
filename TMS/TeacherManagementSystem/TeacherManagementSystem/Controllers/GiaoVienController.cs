using System;
using System.Collections.Generic;
using System.Linq;
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


            return View();
        }

        // GET: GiaoVien/Them
        public ActionResult Them()
        {
            TinhThanhPho tp = new TinhThanhPho();
            var connectionString = ConfigurationManager.ConnectionStrings["Teacher"].ConnectionString;
            List<string> BoMon = new List<string>();
            //get max id
            using (var connection = new SqlConnection(cn))
            {
                connection.Open();
                var getMaxTeacherId = "select MAX(MaGV) from GiaoVien";
                SqlCommand sqlCommand = new SqlCommand(getMaxTeacherId, connection);
                var maxId = (int)sqlCommand.ExecuteScalar();
                var newMaxId = maxId + 1;
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
                return RedirectToAction("Index", "Home");

            }
        }
    }
}