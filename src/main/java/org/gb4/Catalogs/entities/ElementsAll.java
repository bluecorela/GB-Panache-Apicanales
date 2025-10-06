package org.gb4.Catalogs.entities;

import io.quarkus.hibernate.reactive.panache.PanacheEntityBase;
import jakarta.persistence.*;
import org.hibernate.annotations.Immutable;
import com.fasterxml.jackson.annotation.JsonBackReference;

import java.time.LocalDateTime;

@Entity
@Table(name = "element_all")       // 👈 Mapea la vista unificada (approved + pending)
@Immutable                        // 👈 Importante: vistas = solo lectura
public class ElementsAll extends PanacheEntityBase {

    // 🆔 Clave primaria lógica (la vista debe devolver un campo único)
    @Id
    @Column(name = "element_id")
    public Integer id;

    // 📛 Nombre del elemento
    @Column(name = "element_name", length = 50, nullable = false)
    public String name;

    // ✅ Estado del elemento (bit(1) -> Boolean)
    @Column(name = "status", nullable = false, columnDefinition = "bit(1)")
    public Boolean status;

    // 👤 Usuario que creó el registro
    @Column(name = "created_by", nullable = false)
    public Integer createdBy;

    // 📅 Fecha de creación
    @Column(name = "created_date", nullable = false)
    public LocalDateTime createdDate;

    // 👤 Usuario que aprobó el registro
    @Column(name = "approved_by", nullable = false)
    public Integer approvedBy;

    // 📅 Fecha de aprobación
    @Column(name = "approved_date", nullable = false)
    public LocalDateTime approvedDate;

    // 🪪 Origen de la data ("approved" o "pending")
    @Column(name = "source", nullable = false, length = 16)
    public String source;

    // 🧩 Relación con la vista de catálogos (catalog_all)
    @ManyToOne(fetch = FetchType.EAGER)
      @JoinColumns({
        @JoinColumn(name = "catalog_id", referencedColumnName = "catalog_id", insertable = false, updatable = false),
        @JoinColumn(name = "RID", referencedColumnName = "RID", insertable = false, updatable = false)
    })
    @JsonBackReference
    public CatalogosAll catalog;
}
