export interface Books {
    id: string;
    title: string;
    author: string;
    price: number;
    state: "horrendous" | "bad" | "okay" | "passable" | "acceptable" | "good" | "excellent" | "brandNew";
}
