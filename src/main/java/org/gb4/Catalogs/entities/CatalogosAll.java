package org.gb4.Catalogs.entities;

import io.quarkus.hibernate.reactive.panache.PanacheEntityBase;
import jakarta.persistence.*;
import org.hibernate.annotations.Immutable;
import com.fasterxml.jackson.annotation.JsonManagedReference;

import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

@Entity
@Table(name = "catalog_all")  // 👈 apunta a la VISTA, no a la tabla
@Immutable                   // 👈 muy importante, las vistas no se pueden modificar
public class CatalogosAll extends PanacheEntityBase {

    @Id
    @Column(name = "catalog_id")   // 👈 sigue siendo el PK lógico
    public Integer ids;

    @Column(name = "catalog_name", length = 50, nullable = false)
    public String name;

    @Column(name = "catalog_code", length = 50, nullable = false)
    public String codes;

    @Column(name = "created_by", nullable = false)
    public Integer createdBy;

    @Column(name = "created_date", nullable = false)
    public LocalDateTime createdDate;

    @Column(name = "approved_by", nullable = false)
    public Integer approvedBy;

    @Column(name = "approved_date", nullable = false)
    public LocalDateTime approvedDate;

    @Column(name = "source", nullable = false, length = 16)
    public String source; // 👈 "approved" o "pending" de la vista
    
    @Column(name = "RID")   
    public Integer RID;

    // ✅ Relación con la vista de elementos
    @OneToMany(mappedBy = "catalog", fetch = FetchType.EAGER)
    @JsonManagedReference
    public List<ElementsAll> elements = new ArrayList<>();
}
