package org.gb4.entities;

import io.quarkus.hibernate.reactive.panache.PanacheEntityBase;
import jakarta.persistence.*;
import org.hibernate.annotations.CreationTimestamp;

import com.fasterxml.jackson.annotation.JsonBackReference;

import java.time.LocalDateTime;

@Entity
@Table(
    name = "mdl04_description",
    uniqueConstraints = {
        @UniqueConstraint(
            name = "uk_mdl04_description_element_id_language_id",
            columnNames = {"element_id", "language_id"}
        )
    },
    indexes = {
        @Index(
            name = "idx_mdl04_description_language_id_element_id",
            columnList = "element_id,language_id"
        )
    }
)
public class Description extends PanacheEntityBase {

    @Id
    @Column(name = "description_id")
    public Integer id;

    // FK → Element
    @ManyToOne
    @JoinColumn(name = "element_id", referencedColumnName = "element_id")
     @JsonBackReference
    public Element element;

    @Column(name = "language", length = 2, nullable = false)
    public String language;

    @Column(name = "description", length = 250, nullable = false)
    public String description;

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
}
