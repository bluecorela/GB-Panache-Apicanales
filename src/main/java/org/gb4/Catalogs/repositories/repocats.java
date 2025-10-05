package org.gb4.Catalogs.repositories;
import org.gb4.Catalogs.entities.CatalogosAll;


import io.quarkus.hibernate.reactive.panache.PanacheRepositoryBase;
import  jakarta.enterprise.context.ApplicationScoped;

@ApplicationScoped
public class repocats implements PanacheRepositoryBase<CatalogosAll,Long>{
    
}

