using Oracle.DataAccess.Client;
using System;
using System.Configuration;
using System.Data;
using System.Windows.Forms;

//**********************************************************
//* THE CODE IN THIS CLASS CANNOT BE MODIFIED OR ADDED TO. *
//*        Report problems to 3311rep@cse.ust.hk.          *
//**********************************************************

public class OracleDBAccess
{

    // Set the connection string to connect to the Oracle database.
    OracleConnection OracleDBConnection = new OracleConnection(ConfigurationManager.ConnectionStrings["UniversityConnectionString"].ConnectionString);

    // Process a SQL SELECT statement.
    public DataTable GetData(string sql)
    {
        try
        {
            if (sql.Trim() == "")
            {
                throw new ArgumentException("The SQL statement is empty.");
            }

            DataTable dt = new DataTable();
            if (OracleDBConnection.State != ConnectionState.Open)
            {
                OracleDBConnection.Open();
                OracleDataAdapter da = new OracleDataAdapter(sql, OracleDBConnection);
                da.Fill(dt);
                OracleDBConnection.Close();
            }
            else
            {
                OracleDataAdapter da = new OracleDataAdapter(sql, OracleDBConnection);
                da.Fill(dt);
            }
            return dt;
        }
        catch (ArgumentException ex)
        {
            MessageBox.Show(ex.Message);
        }
        catch (FormatException ex)
        {
            MessageBox.Show(ex.Message);
        }
        catch (OracleException ex)
        {
            MessageBox.Show(ex.Message);
        }
        catch (StackOverflowException ex)
        {
            MessageBox.Show(ex.Message);
        }
        return null;
    }

    // Process an SQL SELECT statement that returns only a single value.
    // Returns 0 if the table is empty or the column has no values.
    public decimal GetAggregateValue(string sql)
    {
        try
        {
            if (sql.Trim() == "")
            {
                throw new ArgumentException("The SQL statement is empty.");
            }
            object aggregateValue;
            if (OracleDBConnection.State != ConnectionState.Open)
            {
                OracleDBConnection.Open();
                OracleCommand SQLCmd = new OracleCommand(sql, OracleDBConnection);
                SQLCmd.CommandType = CommandType.Text;
                aggregateValue = SQLCmd.ExecuteScalar();
                OracleDBConnection.Close();
            }
            else
            {
                OracleCommand SQLCmd = new OracleCommand(sql, OracleDBConnection);
                SQLCmd.CommandType = CommandType.Text;
                aggregateValue = SQLCmd.ExecuteScalar();
            }
            return (DBNull.Value == aggregateValue ? 0 : Convert.ToDecimal(aggregateValue));
        }
        catch (ArgumentException ex)
        {
            MessageBox.Show(ex.Message);
        }
        catch (FormatException ex)
        {
            MessageBox.Show(ex.Message);
        }
        catch (OracleException ex)
        {
            MessageBox.Show(ex.Message);
        }
        catch (StackOverflowException ex)
        {
            MessageBox.Show(ex.Message);
        }
        return -1;
    }

    // Process SQL INSERT, UPDATE and DELETE statements.
    public bool SetData(string sql, OracleTransaction trans)
    {
        try
        {
            if (sql.Trim() == "")
            {
                throw new ArgumentException("The SQL statement is empty.");
            }

            OracleCommand SQLCmd = new OracleCommand(sql, OracleDBConnection);
            SQLCmd.Transaction = trans;
            SQLCmd.CommandType = CommandType.Text;
            SQLCmd.ExecuteNonQuery();
            return true;
        }
        catch (ArgumentException ex)
        {
            OracleDBConnection.Close();
            MessageBox.Show(ex.Message);
            return false;
        }
        catch (FormatException ex)
        {
            OracleDBConnection.Close();
            MessageBox.Show(ex.Message);
            return false;
        }
        catch (ApplicationException ex)
        {
            OracleDBConnection.Close();
            MessageBox.Show(ex.Message);
            return false;
        }
        catch (OracleException ex)
        {
            OracleDBConnection.Close();
            MessageBox.Show(ex.Message);
            return false;
        }
        catch (InvalidOperationException ex)
        {
            OracleDBConnection.Close();
            MessageBox.Show(ex.Message);
            return false;
        }
    }

    public OracleTransaction BeginTransaction()
    {
        try
        {
            if (OracleDBConnection.State != ConnectionState.Open)
            {
                OracleDBConnection.Open();
                OracleTransaction trans = OracleDBConnection.BeginTransaction();
                return trans;
            }
            else
            {
                OracleTransaction trans = OracleDBConnection.BeginTransaction();
                return trans;
            }
        }
        catch (InvalidOperationException ex)
        {
            MessageBox.Show(ex.Message);
            return null;
        }
    }

    public void CommitTransaction(OracleTransaction trans)
    {
        try
        {
            if (OracleDBConnection.State == ConnectionState.Open)
            {
                trans.Commit();
                OracleDBConnection.Close();
            }
        }
        catch (ApplicationException ex)
        {
            MessageBox.Show(ex.Message);
        }
        catch (FormatException ex)
        {
            MessageBox.Show(ex.Message);
        }
        catch (OracleException ex)
        {
            MessageBox.Show(ex.Message);
        }
        catch (InvalidOperationException ex)
        {
            MessageBox.Show(ex.Message);
        }
    }

    public void DisposeTransaction(OracleTransaction trans)
    {
        try
        {
            if (OracleDBConnection.State == ConnectionState.Open)
            {
                trans.Dispose();
                OracleDBConnection.Close();
            }
        }
        catch (ApplicationException ex)
        {
            MessageBox.Show(ex.Message);
        }
        catch (FormatException ex)
        {
            MessageBox.Show(ex.Message);
        }
        catch (OracleException ex)
        {
            MessageBox.Show(ex.Message);
        }
        catch (InvalidOperationException ex)
        {
            MessageBox.Show(ex.Message);
        }
    }

    public int GetNextTableId(string idName, string tableName)
    {
        // Get the next available id for the table by selecting the maximum current id and adding 1.
        decimal maxTableId = GetAggregateValue("select max(" + idName + ") from " + tableName);
        // Check whether this is the first record being added to the database.
        if (maxTableId == -1)
        {
            MessageBox.Show("Error getting table id. \n Please contact 3311 Rep.");
        }
        return Convert.ToInt32(maxTableId + 1);
    }
}