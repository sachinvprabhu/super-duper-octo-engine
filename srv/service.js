let implementation = function(service){
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
        let {rating} = await SELECT("rating").one.from("AlternateSuppliers")
                            .where({ID:req.params[0].ID});
        if(rating < 5){
            rating = rating+1;
            await UPDATE("AlternateSuppliers").set({rating:rating}).where({ID:req.params[0].ID})
            req.notify("Rating Updated")
        } else {
            req.notify("Rating already high")
        }

    })

    
    service.on("downRate","AlternateSuppliers",async function(req){
        let entity = await SELECT.one.from("AlternateSuppliers")
                            .where({ID:req.params[0].ID});
        let rating = entity.rating;
        if(rating > 0){
            rating = rating - 1;
            await UPDATE("AlternateSuppliers").set({rating:rating}).where({ID:req.params[0].ID})
            req.notify("Rating Updated")
        } else {
            req.notify("Rating already Low")
        }

    })



}



module.exports = implementation;