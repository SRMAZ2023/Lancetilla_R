interface InventoryStatus {
    label: string;
    value: string;
}

interface ApiResponse {
    code: number;
    // otras propiedades de la respuesta si las hay
}

export interface Product {
    id?: string;
    code?: string;
    name?: string;
    description?: string;
    price?: number;
    quantity?: number;
    inventoryStatus?: InventoryStatus;
    category?: string;
    image?: string;
    rating?: number;
}


export interface nuevo {
    id?: string;
    code?: string;
    name?: string;
    description?: string;
    price?: number;
    quantity?: number;
    inventoryStatus?: InventoryStatus;
    category?: string;
    image?: string;
    rating?: number;
}

export class Especies {
    static cate_Id: any;
    constructor(
        public espe_Id?: 0,
        public espe_Descripcion?: string,
        public espe_UserCreacion?: 0,
        public espe_UserModificacion?: 0
    ) {

    }
}