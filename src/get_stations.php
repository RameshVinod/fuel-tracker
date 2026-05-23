<?php
header('Content-Type: application/json');
header('Access-Control-Allow-Origin: *');

require_once 'config.php';

try {
    $query = "
        SELECT 
            fs.id, 
            fs.station_name, 
            fs.company, 
            fs.area, 
            fs.latitude, 
            fs.longitude,
            COALESCE(
                json_agg(
                    json_build_object(
                        'fuel_type', fst.fuel_type,
                        'stock_status', fst.stock_status,
                        'queue_status', fst.queue_status,
                        'last_updated', fst.last_updated
                    )
                ) FILTER (WHERE fst.fuel_type IS NOT NULL), '[]'
            ) as fuel_stocks
        FROM fuel_stations fs
        LEFT JOIN fuel_status fst ON fs.id = fst.station_id
        GROUP BY fs.id;
    ";

    $stmt = $pdo->query($query);
    $stations = $stmt->fetchAll();

    // හැම row එකකම තියෙන fuel_stocks string එක පිරිසිදු JSON array එකක් බවට පත් කිරීම
    foreach ($stations as &$station) {
        $station['fuel_stocks'] = json_decode($station['fuel_stocks']);
    }

    echo json_encode([
        "status" => "success",
        "data" => $stations
    ], JSON_PRETTY_PRINT);

} catch (PDOException $e) {
    echo json_encode([
        "status" => "error",
        "message" => "Query failed: " . $e->getMessage()
    ]);
}
