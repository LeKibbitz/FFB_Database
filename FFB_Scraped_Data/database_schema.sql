-- FFB Database Schema
-- Generated on: 2025-07-31 22:45:13
-- Based on analysis of entities: 1 (FFB), 2 (Zone), 18 (Ligue), 38 (Comité), 850 (Club)

-- Entity Types
CREATE TYPE entity_type AS ENUM ('FFB', 'Zone', 'Ligue', 'Comité', 'Club');
-- Status Types
CREATE TYPE entity_status AS ENUM ('Actif', 'Inactif', 'En attente');
-- Member Types
CREATE TYPE member_type AS ENUM ('Payé', 'Non payé', 'En attente');

-- Table: entities
CREATE TABLE entities (
    se_souvenir_de_moi BOOLEAN -- Se souvenir de moi,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP -- Date de création,
    created_by VARCHAR(100) -- Créé par,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP -- Date de modification,
    updated_by VARCHAR(100) -- Modifié par,
    soft_deleted BOOLEAN DEFAULT FALSE -- Supprimé logiquement
);

-- Indexes
CREATE INDEX idx_entities_type ON entities(type_entite);
CREATE INDEX idx_entities_soft_deleted ON entities(soft_deleted);
CREATE INDEX idx_members_license_number ON members(license_number);
CREATE INDEX idx_members_entity_code ON members(entity_code);
CREATE INDEX idx_members_soft_deleted ON members(soft_deleted);
CREATE INDEX idx_entity_actors_entity_id ON entity_actors(entity_id);
CREATE INDEX idx_entity_actors_statut ON entity_actors(statut);
CREATE INDEX idx_entity_addresses_jeu_entity_id ON entity_addresses_jeu(entity_id);
CREATE INDEX idx_entity_addresses_courrier_entity_id ON entity_addresses_courrier(entity_id);
CREATE INDEX idx_entity_addresses_facturation_entity_id ON entity_addresses_facturation(entity_id);

-- Foreign Key Constraints
ALTER TABLE entity_actors ADD CONSTRAINT fk_entity_actors_entity_id FOREIGN KEY (entity_id) REFERENCES entities(entity_code);
ALTER TABLE entity_coordinates ADD CONSTRAINT fk_entity_coordinates_entity_id FOREIGN KEY (entity_id) REFERENCES entities(entity_code);
ALTER TABLE entity_notifications ADD CONSTRAINT fk_entity_notifications_entity_id FOREIGN KEY (entity_id) REFERENCES entities(entity_code);
ALTER TABLE entity_complementary_info ADD CONSTRAINT fk_entity_complementary_info_entity_id FOREIGN KEY (entity_id) REFERENCES entities(entity_code);
ALTER TABLE entity_photos ADD CONSTRAINT fk_entity_photos_entity_id FOREIGN KEY (entity_id) REFERENCES entities(entity_code);
ALTER TABLE entity_addresses_jeu ADD CONSTRAINT fk_entity_addresses_jeu_entity_id FOREIGN KEY (entity_id) REFERENCES entities(entity_code);
ALTER TABLE entity_addresses_courrier ADD CONSTRAINT fk_entity_addresses_courrier_entity_id FOREIGN KEY (entity_id) REFERENCES entities(entity_code);
ALTER TABLE entity_addresses_facturation ADD CONSTRAINT fk_entity_addresses_facturation_entity_id FOREIGN KEY (entity_id) REFERENCES entities(entity_code);
ALTER TABLE members ADD CONSTRAINT fk_members_entity_code FOREIGN KEY (entity_code) REFERENCES entities(entity_code);

-- Triggers

CREATE OR REPLACE FUNCTION update_updated_at_column()
RETURNS TRIGGER AS $$
BEGIN
    NEW.updated_at = CURRENT_TIMESTAMP;
    RETURN NEW;
END;
$$ language 'plpgsql';

CREATE TRIGGER update_entities_updated_at BEFORE UPDATE ON entities FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();
