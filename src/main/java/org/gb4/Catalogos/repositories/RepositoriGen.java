package org.gb4.Catalogos.repositories;
import org.gb4.Catalogos.entities.Catalog;

import io.quarkus.hibernate.reactive.panache.PanacheRepositoryBase;
import  jakarta.enterprise.context.ApplicationScoped;

@ApplicationScoped
public class RepositoriGen implements PanacheRepositoryBase<Catalog,Long> {

}
