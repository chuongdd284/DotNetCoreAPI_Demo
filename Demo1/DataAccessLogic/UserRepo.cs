using Demo1.Models;
using Demo1.Models.Requests;
using Demo1.Models.Responses;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Configuration;
using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Threading.Tasks;

namespace Demo1.DataAccessLogic
{
    public class UserRepo
    {
        private readonly string _conString;
        public UserRepo(IConfiguration configuration)
        {
            _conString = configuration.GetConnectionString("secondConnection"); //DemoWeek1DB
        }
        private User MapToUser(SqlDataReader reader)
        {
            return new User()
            {
                Id = (int)reader["Id"],
                UserName = reader["UserName"].ToString(),
                Password = reader["Password"].ToString(),
                FullName = reader["FullName"].ToString(),
                Role = reader["Role"].ToString()
            };
        }
        public async Task<List<User>> GetAll()
        {
            using (SqlConnection sql = new SqlConnection(_conString))
            {
                using (SqlCommand cmd = new SqlCommand("GetAllUsers", sql))
                {
                    cmd.CommandType = System.Data.CommandType.StoredProcedure;
                    var response = new List<User>();
                    await sql.OpenAsync();

                    using (var reader = await cmd.ExecuteReaderAsync())
                    {
                        while (await reader.ReadAsync())
                        {
                            response.Add(MapToUser(reader));
                        }
                    }

                    return response;
                }
            }
        }
        public async Task<User> GetById(int Id)
        {
            using (SqlConnection sql = new SqlConnection(_conString))
            {
                using (SqlCommand cmd = new SqlCommand("GetUserById", sql))
                {
                    cmd.CommandType = System.Data.CommandType.StoredProcedure;
                    cmd.Parameters.Add(new SqlParameter("@Id", Id));
                    User response = null;
                    await sql.OpenAsync();

                    using (var reader = await cmd.ExecuteReaderAsync())
                    {
                        while (await reader.ReadAsync())
                        {
                            response = MapToUser(reader);
                        }
                    }
                    return response;
                }
            }
        }
        /*public async Task<User> UpdateById(int Id)
        {
            throw new NotImplementedException();
        }*/
        public async Task<List<User>> GetUsersByRole(string role) //return all users by specific role
        {
            using (SqlConnection sql = new SqlConnection(_conString))
            {
                using (SqlCommand cmd = new SqlCommand("GetUsersByRole", sql))
                {
                    cmd.CommandType = System.Data.CommandType.StoredProcedure;
                    cmd.Parameters.Add(new SqlParameter("@Role", role));
                    var response = new List<User>();
                    await sql.OpenAsync();
                    using (var reader = await cmd.ExecuteReaderAsync())
                    {
                        while (await reader.ReadAsync())
                        {
                            response.Add(MapToUser(reader));
                        }
                    }
                    return response;
                }
            }
        }
        public async Task<List<User>> SearchByUserName(string Name)
        {
            using (SqlConnection sql = new SqlConnection(_conString))
            {
                using (SqlCommand cmd = new SqlCommand("SearchByUserName", sql))
                {
                    cmd.CommandType = System.Data.CommandType.StoredProcedure;
                    cmd.Parameters.Add(new SqlParameter("@Name", Name));
                    var response = new List<User>();
                    await sql.OpenAsync();
                    //using (var reader = await cmd.ExecuteReaderAsync())
                    using (var reader = await cmd.ExecuteReaderAsync())
                    {
                        while (await reader.ReadAsync())
                        {
                            response.Add(MapToUser(reader));
                        }
                    }
                    return response;
                }
            }
        }
        public async Task InsertUser(User user)
        {
            using (SqlConnection sql = new SqlConnection(_conString))
            {
                using (SqlCommand cmd = new SqlCommand("AddUser", sql))
                {
                    cmd.CommandType = System.Data.CommandType.StoredProcedure;
                    cmd.Parameters.Add(new SqlParameter("@UserName", user.UserName));
                    cmd.Parameters.Add(new SqlParameter("@Password", user.Password));
                    cmd.Parameters.Add(new SqlParameter("@FullName", user.FullName));
                    cmd.Parameters.Add(new SqlParameter("@Role", user.Role));
                    await sql.OpenAsync();
                    await cmd.ExecuteNonQueryAsync();
                    return;
                }
            }
        }
        public async Task Update(int Id, User user)
        {
            using (SqlConnection sql = new SqlConnection(_conString))
            {
                using (SqlCommand cmd = new SqlCommand("UpdateUserById", sql))
                {
                    cmd.CommandType = System.Data.CommandType.StoredProcedure;
                    cmd.Parameters.Add(new SqlParameter("@Id", Id));
                    cmd.Parameters.Add(new SqlParameter("@UserName", user.UserName));
                    cmd.Parameters.Add(new SqlParameter("@Password", user.Password));
                    cmd.Parameters.Add(new SqlParameter("@FullName", user.FullName));
                    cmd.Parameters.Add(new SqlParameter("@Role", user.Role));
                    await sql.OpenAsync();
                    await cmd.ExecuteNonQueryAsync();
                    return;
                }
            }
        }
        public async Task DeleteById(int Id)
        {
            using (SqlConnection sql = new SqlConnection(_conString))
            {
                using (SqlCommand cmd = new SqlCommand("DeleteUserById", sql))
                {
                    cmd.CommandType = System.Data.CommandType.StoredProcedure;
                    cmd.Parameters.Add(new SqlParameter("@Id", Id));
                    await sql.OpenAsync();
                    await cmd.ExecuteNonQueryAsync();
                    return;
                }
            }
        }
        public async Task<ActionResult<BaseResponse>> Login(LoginRequest login)
        {
            throw new NotImplementedException();
        }
    }
}
