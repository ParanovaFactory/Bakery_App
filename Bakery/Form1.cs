using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Data.SqlClient;
using System.Drawing;
using System.Linq;
using System.Security.Cryptography;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace Bakery
{
    public partial class Form1 : Form
    {
        public Form1()
        {
            InitializeComponent();
        }

        SqlConnection connection = new SqlConnection(@"Data Source=predator;Initial Catalog=Bd_Bakery;Integrated Security=True;TrustServerCertificate=True");

        void listCash()
        {
            connection.Open();
            SqlCommand cmd = new SqlCommand("select * from TblCashreg", connection);
            SqlDataAdapter adapter = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();
            adapter.Fill(dt);
            dgvCash.DataSource = dt;
            connection.Close();
        }

        void listUnit()
        {
            connection.Open();
            SqlCommand cmd = new SqlCommand("select * from TblUnits", connection);
            SqlDataAdapter adapter = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();
            adapter.Fill(dt);
            dgvUnit.DataSource = dt;
            connection.Close();
        }

        void listProduct()
        {
            connection.Open();
            SqlCommand cmd = new SqlCommand("select * from TblProducts", connection);
            SqlDataAdapter adapter = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();
            adapter.Fill(dt);
            dgvProduct.DataSource = dt;
            connection.Close();
        }

        void listReceipt()
        {
            connection.Open();
            SqlCommand cmd = new SqlCommand("select receiptId, unitName, productName, unitAmount, unitCost from TblReceipt inner join TblProducts on TblProducts.productId = TblReceipt.productReceiptId inner join TblUnits on TblUnits.unitId = TblReceipt.unitReceiptId", connection);
            SqlDataAdapter adapter = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();
            adapter.Fill(dt);
            dgvReceipt.DataSource = dt;
            connection.Close();
        }

        void listCmbProd()
        {
            connection.Open();
            SqlDataAdapter adapter = new SqlDataAdapter("select * from TblProducts", connection);
            DataTable dt = new DataTable();
            adapter.Fill(dt);
            cmbProduct.ValueMember = "productId";
            cmbProduct.DisplayMember = "productName";
            cmbProduct.DataSource = dt;
            connection.Close();
        }

        void listCmbUnit()
        {
            connection.Open();
            SqlDataAdapter adapter1 = new SqlDataAdapter("select * from TblUnits", connection);
            DataTable dt1 = new DataTable();
            adapter1.Fill(dt1);
            cmbUnit.ValueMember = "unitId";
            cmbUnit.DisplayMember = "unitName";
            cmbUnit.DataSource = dt1;
            connection.Close();
        }

        private void Form1_Load(object sender, EventArgs e)
        {
            listCash();
            listUnit();
            listProduct();
            listReceipt();
            listCmbProd();
            listCmbUnit();
        }

        private void txtNewUnit_Click(object sender, EventArgs e)
        {
            connection.Open();
            SqlCommand cmd = new SqlCommand("insert into TblUnits (unitName, unitStok, unitPrice, unitNote) values(@p1, @p2, @p3, @p4)", connection);
            cmd.Parameters.AddWithValue("@p1", txtUnitName.Text);
            cmd.Parameters.AddWithValue("@p2", txtUnitStock.Text);
            cmd.Parameters.AddWithValue("@p3", txtUnitPrice.Text);
            cmd.Parameters.AddWithValue("@p4", txtUnitNote.Text);
            cmd.ExecuteNonQuery();
            connection.Close();
            listUnit();
        }

        private void btnUpdateUnit_Click(object sender, EventArgs e)
        {
            connection.Open();
            SqlCommand cmd = new SqlCommand("update TblUnits set unitName=@p1, unitStok=@p2, unitPrice=@p3, unitNote=@p4 where unitId=@p5", connection);
            cmd.Parameters.AddWithValue("@p1", txtUnitName.Text);
            cmd.Parameters.AddWithValue("@p2", txtUnitStock.Text);
            cmd.Parameters.AddWithValue("@p3", txtUnitPrice.Text);
            cmd.Parameters.AddWithValue("@p4", txtUnitNote.Text);
            cmd.Parameters.AddWithValue("@p5", txtUnitId.Text);
            cmd.ExecuteNonQuery();
            connection.Close();
            listUnit();
        }

        private void btnAddProduct_Click(object sender, EventArgs e)
        {
            connection.Open();
            SqlCommand cmd = new SqlCommand("insert into TblProducts (productName) values(@p1)", connection);
            cmd.Parameters.AddWithValue("@p1", txtProductName.Text);
            cmd.ExecuteNonQuery();
            connection.Close();
            listProduct();
        }

        private void btnUpdateCost_Click(object sender, EventArgs e)
        {
            connection.Open();
            SqlCommand cmd = new SqlCommand("update TblProducts set productCost=@p2, productPrice=@p3, productStock=@p4 where productId=@p5", connection);
            cmd.Parameters.AddWithValue("@p2", txtProductCost.Text);
            cmd.Parameters.AddWithValue("@p3", txtProductPrice.Text);
            cmd.Parameters.AddWithValue("@p4", txtProductStock.Text);
            cmd.Parameters.AddWithValue("@p5", txtProductId.Text);
            cmd.ExecuteNonQuery();


            SqlCommand cmd1 = new SqlCommand("update TblCashReg set income += @p1, cost += @p2, profit += @p3", connection);
            decimal cost, price, piece;
            cost = Convert.ToDecimal(txtProductCost.Text);
            price = Convert.ToDecimal(txtProductPrice.Text);
            piece = Convert.ToDecimal(txtProductStock.Text);
            cmd1.Parameters.AddWithValue("@p1", price * piece);
            cmd1.Parameters.AddWithValue("@p2", cost * piece);
            cmd1.Parameters.AddWithValue("@p3", (price * piece) - (cost * piece));
            cmd1.ExecuteNonQuery();
            connection.Close();

            listProduct();
            listCash();
        }

        private void btnNewReceipt_Click(object sender, EventArgs e)
        {
            connection.Open();
            SqlCommand cmd = new SqlCommand("insert into TblReceipt (unitReceiptId, productReceiptId, unitAmount, unitCost) values(@p1, @p2, @p3, @p4)", connection);
            cmd.Parameters.AddWithValue("@p1", cmbUnit.SelectedValue);
            cmd.Parameters.AddWithValue("@p2", cmbProduct.SelectedValue);
            cmd.Parameters.AddWithValue("@p3", txtReceiptAmount.Text);
            cmd.Parameters.AddWithValue("@p4", txtReceiptCost.Text);
            cmd.ExecuteNonQuery();
            connection.Close();

            listBox1.Items.Add(cmbProduct.Text + " " + cmbUnit.Text + " " + txtReceiptAmount.Text + " " + txtReceiptCost.Text);
            txtReceiptAmount.Text = "0";

            listCash();
            listUnit();
            listProduct();
            listReceipt();
        }

        private void dgvProduct_CellClick(object sender, DataGridViewCellEventArgs e)
        {
            txtProductId.Text = dgvProduct.Rows[e.RowIndex].Cells[0].Value.ToString();
            txtProductName.Text = dgvProduct.Rows[e.RowIndex].Cells[1].Value.ToString();
            txtProductCost.Text = dgvProduct.Rows[e.RowIndex].Cells[2].Value.ToString();
            txtProductPrice.Text = dgvProduct.Rows[e.RowIndex].Cells[3].Value.ToString();
            txtProductStock.Text = dgvProduct.Rows[e.RowIndex].Cells[4].Value.ToString();

            connection.Open();
            SqlCommand cmd = new SqlCommand("select sum(unitCost) from TblReceipt where productReceiptId = @p1", connection);
            cmd.Parameters.AddWithValue("@p1", txtProductId.Text);
            SqlDataReader reader = cmd.ExecuteReader();
            while (reader.Read())
            {
                txtProductCost.Text = reader[0].ToString();
            }
            connection.Close();
        }

        private void dgvUnit_CellClick(object sender, DataGridViewCellEventArgs e)
        {
            txtUnitId.Text = dgvUnit.Rows[e.RowIndex].Cells[0].Value.ToString();
            txtUnitName.Text = dgvUnit.Rows[e.RowIndex].Cells[1].Value.ToString();
            txtUnitStock.Text = dgvUnit.Rows[e.RowIndex].Cells[2].Value.ToString();
            txtUnitPrice.Text = dgvUnit.Rows[e.RowIndex].Cells[3].Value.ToString();
            txtUnitNote.Text = dgvUnit.Rows[e.RowIndex].Cells[4].Value.ToString();
        }

        private void dgvReceipt_CellClick(object sender, DataGridViewCellEventArgs e)
        {
            string id = dgvReceipt.Rows[e.RowIndex].Cells[0].Value.ToString();
            cmbProduct.Text = dgvReceipt.Rows[e.RowIndex].Cells[1].Value.ToString();
            cmbUnit.Text = dgvReceipt.Rows[e.RowIndex].Cells[2].Value.ToString();
            txtReceiptAmount.Text = dgvReceipt.Rows[e.RowIndex].Cells[3].Value.ToString();
            txtReceiptCost.Text = dgvReceipt.Rows[e.RowIndex].Cells[4].Value.ToString();
        }

        private void txtReceiptAmount_TextChanged(object sender, EventArgs e)
        {
            decimal amount = decimal.Parse(txtReceiptAmount.Text), price = 0, cost = 0;

            connection.Open();
            SqlCommand sqlCommand = new SqlCommand("select unitPrice from TblUnits where unitId=@p1", connection);
            sqlCommand.Parameters.AddWithValue("@p1", cmbUnit.SelectedValue);
            SqlDataReader reader = sqlCommand.ExecuteReader();
            while (reader.Read())
            {
                price = reader.GetDecimal(0) / 1000;
            }

            cost = amount * price;
            txtReceiptCost.Text = cost.ToString();
            connection.Close();
        }
    }
}
