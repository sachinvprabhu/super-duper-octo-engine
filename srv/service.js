let implementation = async function(service){

    let S4API = await cds.connect.to("API_INFORECORD_PROCESS_SRV");
    service.on("READ","A_PurchasingInfoRecord",function(req){
        // Sanitize Request
        req.query.SELECT.columns.push({ref:['Supplier']});

        return S4API.read(req.query).then(async entries=>{
            if(entries.constructor === Array){
                for(index in entries){
                    let locationGeo = await SELECT.one.from("ResilienceCockpit.SupplierLocations")
                            .where({Supplier:entries[index].Supplier});
                    if(locationGeo){
                        entries[index].Lat = locationGeo.Lat;
                        entries[index].Lng = locationGeo.Lng;
                    } else {
                        entries[index].Lat = 0;
                        entries[index].Lng = 0;
                    }
                }
            } else {
                let locationGeo = await SELECT.one.from("ResilienceCockpit.SupplierLocations")
                            .where({Supplier:entries.Supplier});
                if(locationGeo){
                    entries.Lat = locationGeo.Lat;
                    entries.Lng = locationGeo.Lng;
                } else {
                    entries.Lat = 0;
                    entries.Lng = 0;
                }     
            }
            return entries;
        })
    });

    service.after("READ","AlternateSuppliers",function(data, req){
        for(let index in data){
            if(data[index].rating === 5){
                data[index].supplierName = data[index].supplierName + " -highly rated"
            }
        }

        data.forEach(async element => {
            await new Promise((resolve,reject)=>setTimeout(resolve,1000));
            console.log(element.ID)

            if(new Date(element.modifiedAt).toDateString() === new Date().toDateString()){
                element.supplierName = element.supplierName + "- recently updated"
            }
        });

    })

    service.before("CREATE","AlternateSuppliers",async function(req){
        let country = await SELECT.one.from("sap.common.Countries")
                        .where({code:req.data.country_code});
        if(!country){
            return req.error(400, 'Country not found');
        }
    });

    service.before("UPDATE","AlternateSuppliers",async function(req){
        if(req.data.country_code){
            let country = await SELECT.one.from("sap.common.Countries")
                            .where({code:req.data.country_code});
            if(!country){
                return req.error(400, 'Country not found');
            }
        }
        
    })

    service.on("upRate","AlternateSuppliers",async function(req){
        let entity = await SELECT.one.from("AlternateSuppliers")
                            .where({ID:req.params[0].ID});
        if(entity){
            if(entity.rating < 5){
                entity.rating = entity.rating+1;
                await UPDATE("AlternateSuppliers").set({rating:entity.rating}).where({ID:req.params[0].ID})
                req.notify("Rating Updated");
            } else {
                req.notify("Rating already high")
            }
            return entity;
        } else {
            req.error("Supplier not found")
        }
    })

    
    service.on("downRate","AlternateSuppliers",async function(req){
        let entity = await SELECT.one.from("AlternateSuppliers")
                            .where({ID:req.params[0].ID});
        if(entity){
            if(entity.rating > 0){
                entity.rating = entity.rating - 1;
                await UPDATE("AlternateSuppliers").set({rating:entity.rating}).where({ID:req.params[0].ID})
                req.notify("Rating Updated")
                return entity;
            } else {
                req.notify("Rating already Low")
                return entity;
            }
        } else {
            req.error("Supplier not found")
        }

    })



}



module.exports = implementation;