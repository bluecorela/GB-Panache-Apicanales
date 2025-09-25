package org.gb4.entities;


import io.quarkus.hibernate.reactive.panache.PanacheEntityBase;
import jakarta.persistence.*;
import org.hibernate.annotations.CreationTimestamp;

import com.fasterxml.jackson.annotation.JsonBackReference;
import com.fasterxml.jackson.annotation.JsonManagedReference;

import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

@Entity
@Table(
    name = "mdl04_element",
    indexes = {
        @Index(name = "idx_mdl04_element_catalog_id_element_name", columnList = "catalog_id,element_name")
    }
)
public class Element extends PanacheEntityBase {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "element_id")
    public Integer id;

    // FK -> Catalog
    
    
    @ManyToOne
    @JoinColumn(name = "catalog_id", referencedColumnName = "catalog_id")
    @JsonBackReference
    public Catalog catalog;

    @Column(name = "element_name", length = 50, nullable = false)
    public String name;

    // bit(1) -> Boolean
    @Column(name = "status", nullable = false, columnDefinition = "bit(1)")
    public Boolean status = Boolean.TRUE;

    @Column(name = "created_by", nullable = false)
    public Integer createdBy;

    @CreationTimestamp
    @Column(name = "created_date", nullable = false)
    public LocalDateTime createdDate;

    @Column(name = "approved_by", nullable = false)
    public Integer approvedBy;

    @CreationTimestamp
    @Column(name = "approved_date", nullable = false)
    public LocalDateTime approvedDate;

     // Relación 1:N con Element
    @OneToMany(mappedBy = "element",cascade = {CascadeType.ALL},fetch = FetchType.EAGER)
    @JsonManagedReference
    public List<Origin> origens = new ArrayList<>();

    @OneToMany(mappedBy = "element",cascade = {CascadeType.ALL},fetch = FetchType.EAGER)
    @JsonManagedReference
    public List<Description> description = new ArrayList<>();
}