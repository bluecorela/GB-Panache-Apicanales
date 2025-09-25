package org.gb4.repositories;
import io.quarkus.hibernate.reactive.panache.PanacheRepositoryBase;
import  jakarta.enterprise.context.ApplicationScoped;
import org.gb4.entities.Catalog;

@ApplicationScoped
public class RepositoriGen implements PanacheRepositoryBase<Catalog,Long> {

}
