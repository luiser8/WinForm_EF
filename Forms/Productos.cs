using Facturacion.Forms;
using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace Facturacion
{
    public partial class Factura : Form
    {
        //Instancia context ef
        Models.FacturacionEntities db = new Models.FacturacionEntities();

        public Factura()
        {
            InitializeComponent();
        }

        private void checkBox1_CheckedChanged(object sender, EventArgs e)
        {

        }

        //Cuando carga el form
        private void Factura_Load(object sender, EventArgs e)
        {
            ResetForm();
        }

        //Boton guardar
        private void btnSalvar_Click(object sender, EventArgs e)
        {
            try
            {
                Models.Producto producto = new Models.Producto();
                producto.Nombre = ProductoNom.Text;
                producto.Descripcion = ProductoDesc.Text;
                producto.Precio = ProductoPrecio.Text;
                producto.Stock = (int)ProductoStock.Value;
                producto.Estado = ProductoEstado.Checked;
                producto.Fecha = DateTime.Now;

                db.Productos.Add(producto);
                db.SaveChanges();

                MessageBox.Show("Producto guardado!");
                ResetForm();
            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message);
            }
        }

        //Limpiar cajas de texto
        private void ResetForm()
        {
            ProductoNom.Text = string.Empty;
            ProductoDesc.Text = string.Empty;
            ProductoPrecio.Text = string.Empty;
            ProductoStock.Value = 0.0M;
            ProductoEstado.Checked = true;

            LoadAllProductos();
        }

        //Llena el datagrid
        private void LoadAllProductos()
        {
            try
            {
                Models.Producto producto = new Models.Producto();
                var query = from prod in db.Productos
                            orderby prod.ProductoId ascending
                            select prod;
                //dgvRecords.DataSource = db.Productos.ToList();
                dgvRecords.DataSource = query.ToList();
            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message);
            }
        }

        //Llama ventana clientes
        private void button1_Click(object sender, EventArgs e)
        {
            Clientes clientes = new Clientes();
            clientes.ShowDialog();
        }

        //Limpiar
        private void btnLimpiar_Click(object sender, EventArgs e)
        {
            ResetForm();
        }

        //Buscar por id
        private void btnCargar_Click(object sender, EventArgs e)
        {
            try
            {
                Models.Producto producto = new Models.Producto();
                var query = from prod in db.Productos
                            where prod.ProductoId == (int)ProductoId.Value
                            select prod;

                Models.Producto productoId = query.SingleOrDefault();

                if (productoId != null)
                {
                    ProductoNom.Text = productoId.Nombre;
                    ProductoDesc.Text = productoId.Descripcion;
                    ProductoPrecio.Text = productoId.Precio;
                    ProductoStock.Value = productoId.Stock;
                    ProductoEstado.Checked = productoId.Estado;

                    dgvRecords.DataSource = query.ToList();
                }
                else
                {
                    MessageBox.Show("No hay registros!");
                }
            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message);
            }
        }

        //Actualizar
        private void btnActualizar_Click(object sender, EventArgs e)
        {
            try
            {
                //Models.Producto producto = new Models.Producto();
                var query = from prod in db.Productos
                            where prod.ProductoId == (int)ProductoId.Value
                            select prod;

                Models.Producto producto = query.SingleOrDefault();

                if (producto != null)
                {
                    producto.ProductoId = (int)ProductoId.Value;
                    producto.Nombre = ProductoNom.Text;
                    producto.Descripcion = ProductoDesc.Text;
                    producto.Precio = ProductoPrecio.Text;
                    producto.Stock = (int)ProductoStock.Value;
                    producto.Estado = ProductoEstado.Checked;
                    producto.Fecha = DateTime.Now;

                    //db.Productos.Add(producto);
                    db.SaveChanges();

                    MessageBox.Show("Producto actualzado!");
                    ResetForm();
                }
                else
                {
                    MessageBox.Show("Registro no actualizado!");
                }
            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message);
            }
        }

        //Eliminar
        private void btnEliminar_Click(object sender, EventArgs e)
        {
            try
            {
                //Models.Producto producto = new Models.Producto();
                var query = from prod in db.Productos
                            where prod.ProductoId == (int)ProductoId.Value
                            select prod;

                Models.Producto producto = query.SingleOrDefault();

                if (producto != null)
                {
                    producto.ProductoId = (int)ProductoId.Value;
                    db.Productos.Remove(producto);
                    db.SaveChanges();

                    MessageBox.Show("Producto Eliminado!");
                    ResetForm();
                }
                else
                {
                    MessageBox.Show("Registro no Eliminado!");
                }
            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message);
            }
        }

        //Buscar por nombre
        private void btnBuscarPorNombre_Click(object sender, EventArgs e)
        {
            try
            {
                var query = from prod in db.Productos
                            where prod.Nombre.Equals(ProductoNom.Text, StringComparison.OrdinalIgnoreCase)
                            orderby prod.Nombre ascending
                            select prod;

                Models.Producto productoId = query.SingleOrDefault();

                if (productoId != null)
                {
                    ProductoId.Value = productoId.ProductoId;
                    ProductoNom.Text = productoId.Nombre;
                    ProductoDesc.Text = productoId.Descripcion;
                    ProductoPrecio.Text = productoId.Precio;
                    ProductoStock.Value = productoId.Stock;
                    ProductoEstado.Checked = productoId.Estado;

                    dgvRecords.DataSource = query.ToList();
                }
                else
                {
                    MessageBox.Show("No hay registros!");
                }
            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message);
            }
        }

        //Filtro por nombres
        private void btnBuscarFiltro_Click(object sender, EventArgs e)
        {
            try
            {

                var query = from prod in db.Productos
                            where prod.Nombre.Contains(ProductoNom.Text)
                            orderby prod.Nombre ascending
                            select prod;

                dgvRecords.DataSource = query.ToList();

            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message);
            }
        }

        //Buscar dando click en el producto
        private void dgvRecords_DoubleClick(object sender, EventArgs e)
        {
            if (dgvRecords.CurrentRow.Index != -1)
            {
                try
                {
                    var Id = Convert.ToInt32(dgvRecords.CurrentRow.Cells["ProductoId"].Value);
                    var query = from prod in db.Productos
                                where prod.ProductoId == Id
                                select prod;

                    Models.Producto productoId = query.SingleOrDefault();

                    if (productoId != null)
                    {
                        ProductoId.Value = productoId.ProductoId;
                        ProductoNom.Text = productoId.Nombre;
                        ProductoDesc.Text = productoId.Descripcion;
                        ProductoPrecio.Text = productoId.Precio;
                        ProductoStock.Value = productoId.Stock;
                        ProductoEstado.Checked = productoId.Estado;

                        dgvRecords.DataSource = query.ToList();
                    }
                    else
                    {
                        MessageBox.Show("No hay registros!");
                    }
                }
                catch (Exception ex)
                {
                    MessageBox.Show(ex.Message);
                }
            }
        }
    }
}
