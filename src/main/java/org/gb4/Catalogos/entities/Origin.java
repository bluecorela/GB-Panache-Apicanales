package org.gb4.Catalogos.entities;

import io.quarkus.hibernate.reactive.panache.PanacheEntityBase;
import jakarta.persistence.*;
import org.hibernate.annotations.CreationTimestamp;

import com.fasterxml.jackson.annotation.JsonBackReference;

import java.time.LocalDateTime;

@Entity
@Table(
    name = "mdl04_origin",
    uniqueConstraints = {
        @UniqueConstraint(name = "uk_mdl04_origin_code", columnNames = "origin_code")
    },
    indexes = {
        @Index(name = "idx_mdl04_origin_code", columnList = "origin_code")
    }
)
public class Origin extends PanacheEntityBase {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "origin_id")
    public Integer id;
    

    // FK -> Element
    @ManyToOne
    @JoinColumn(name = "element_id", referencedColumnName = "element_id")
    @JsonBackReference
    public Element element;

    @Column(name = "origin_description", nullable = false, length = 100)
    public String description;

    @Column(name = "origin_code", nullable = false, length = 10, unique = true)
    public String code;

    @Column(name = "created_by", nullable = false)
    public Integer createdBy;

    @CreationTimestamp
    @Column(name = "created_date", nullable = false, updatable = false)
    public LocalDateTime createdDate;

    @Column(name = "approved_by", nullable = false)
    public Integer approvedBy;

    @CreationTimestamp
    @Column(name = "approved_date", nullable = false, updatable = false)
    public LocalDateTime approvedDate;
}
