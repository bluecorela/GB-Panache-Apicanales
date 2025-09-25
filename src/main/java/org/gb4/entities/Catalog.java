package org.gb4.entities;



import io.quarkus.hibernate.reactive.panache.PanacheEntityBase;
import jakarta.persistence.*;
import org.hibernate.annotations.CreationTimestamp;

import com.fasterxml.jackson.annotation.JsonManagedReference;

import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

@Entity
@Table(
    name = "mdl04_catalog",
    uniqueConstraints = {
        @UniqueConstraint(name = "uk_mdl04_catalog_code", columnNames = "catalog_code")
    },
    indexes = {
        @Index(name = "idx_mdl04_catalog_catalog_name", columnList = "catalog_name")
    }
)
public class Catalog extends PanacheEntityBase {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "catalog_id")
    public Integer id;

    @Column(name = "catalog_name", length = 50, nullable = false)
    public String name;

    @Column(name = "catalog_code", length = 50, nullable = false)
    public String code;

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
    @OneToMany(mappedBy = "catalog",cascade = {CascadeType.ALL},fetch = FetchType.EAGER)
    @JsonManagedReference
    public List<Element> elements = new ArrayList<>();
}
