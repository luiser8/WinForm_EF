//------------------------------------------------------------------------------
// <auto-generated>
//     This code was generated from a template.
//
//     Manual changes to this file may cause unexpected behavior in your application.
//     Manual changes to this file will be overwritten if the code is regenerated.
// </auto-generated>
//------------------------------------------------------------------------------

namespace Facturacion.Models
{
    using System;
    using System.Collections.Generic;
    
    public partial class Factura
    {
        public int FacturaId { get; set; }
        public int OrdenId { get; set; }
        public int ClienteId { get; set; }
        public bool Estado { get; set; }
        public System.DateTime Fecha { get; set; }
    
        public virtual Cliente Cliente { get; set; }
        public virtual Orden Orden { get; set; }
    }
}
