using Demo1.Models;
using Microsoft.Extensions.Configuration;
using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Threading.Tasks;

namespace Demo1.DataAccessLogic
{
    public class ValueRepo
    {
        private readonly string _conString;
        public ValueRepo(IConfiguration configuration)
        {
            _conString = configuration.GetConnectionString("defaultConnection");
        }
       /* public Task<List<Value>> GetAll()
        {
            throw new NotImplementedException();
        }*/
       private Value MapToValue(SqlDataReader reader)
        {
            return new Value()
            {
                Id = (int)reader["Id"],
                Value1 = (int)reader["Value1"],
                Value2 = reader["Value2"].ToString()
            };
        }
       public async Task<List<Value>> GetAll()
        {
            using (SqlConnection sql = new SqlConnection(_conString))
            {
                using (SqlCommand cmd = new SqlCommand("GetAllValues", sql))
                {
                    cmd.CommandType = System.Data.CommandType.StoredProcedure;
                    var response = new List<Value>();
                    await sql.OpenAsync();

                    using (var reader = await cmd.ExecuteReaderAsync())
                    {
                        while (await reader.ReadAsync())
                        {
                            response.Add(MapToValue(reader));
                        }
                    }
                    return response;
                }
            }
        }

        /*public Task<Value> GetById(int Id)
        {
            throw new NotImplementedException();
        }*/
        public async Task<Value> GetById(int Id)
        {
            using (SqlConnection sql = new SqlConnection(_conString))
            {
                using (SqlCommand cmd = new SqlCommand("GetValueById", sql))
                {
                    cmd.CommandType = System.Data.CommandType.StoredProcedure;
                    cmd.Parameters.Add(new SqlParameter("@Id", Id));
                    Value response = null;
                    await sql.OpenAsync();

                    using (var reader = await cmd.ExecuteReaderAsync())
                    {
                        while (await reader.ReadAsync())
                        {
                            response = MapToValue(reader);
                        }
                    }
                    return response;
                }
            }
        }
        /*public Task Insert(Value value)
        {
            throw new NotImplementedException();
        }*/
        public async Task Insert(Value value)
        {
            using (SqlConnection sql = new SqlConnection(_conString))
            {
                using (SqlCommand cmd = new SqlCommand("InsertValue", sql))
                {
                    cmd.CommandType = System.Data.CommandType.StoredProcedure;
                    cmd.Parameters.Add(new SqlParameter("@value1", value.Value1));
                    cmd.Parameters.Add(new SqlParameter("@value2", value.Value2));
                    await sql.OpenAsync();
                    await cmd.ExecuteNonQueryAsync();
                    return;
                }
            }
        }
        /*public Task DeleteById(int Id)
        {
            throw new NotImplementedException();
        }*/
        public async Task DeleteById(int Id)
        {
            using (SqlConnection sql = new SqlConnection(_conString))
            {
                using (SqlCommand cmd = new SqlCommand("DeleteValue", sql))
                {
                    cmd.CommandType = System.Data.CommandType.StoredProcedure;
                    cmd.Parameters.Add(new SqlParameter("@Id", Id));
                    await sql.OpenAsync();
                    await cmd.ExecuteNonQueryAsync();
                    return;
                }
            }
        }
    }
}
