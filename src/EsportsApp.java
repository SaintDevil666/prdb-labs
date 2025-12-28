import com.mongodb.client.*;
import com.mongodb.client.model.*;
import org.bson.Document;
import org.bson.conversions.Bson;
import java.util.Arrays;
import java.util.List;

// MongoDB app for Esports DB - Variant 10 (Style B: compact)
public class EsportsApp {
    static final String CONN = "mongodb://localhost:27017";
    static final String DB = "esports_db";
    MongoClient cli;
    MongoDatabase db;

    public static void main(String[] args) { new EsportsApp().run(); }

    void run() {
        System.out.println("=== Esports MongoDB (PR8) ===\n");
        try {
            connect();
            showAll();
            query();
            aggregate();
        } catch (Exception e) {
            System.err.println("Err: " + e.getMessage());
        } finally {
            if (cli != null) cli.close();
        }
        System.out.println("\n=== Done ===");
    }

    void connect() {
        cli = MongoClients.create(CONN);
        db = cli.getDatabase(DB);
        System.out.println("Connected: " + DB + "\n");
    }

    void showAll() {
        System.out.println("--- ALL DOCS ---\n");
        show("teams"); show("players"); show("tournaments");
    }

    void show(String col) {
        System.out.println(">> " + col);
        var c = db.getCollection(col);
        for (var d : c.find()) System.out.println(d.toJson());
        System.out.println();
    }

    // Query: rating > 9000 AND country = UA
    void query() {
        System.out.println("--- QUERY: rating>9000 AND country=UA ---\n");
        var players = db.getCollection("players");
        var f = Filters.and(Filters.gt("rating", 9000), Filters.eq("country", "UA"));
        for (var p : players.find(f)) {
            System.out.printf("%s (%s) - rating: %d, kd: %.2f%n",
                p.getString("nick"), p.getString("country"),
                p.getInteger("rating"), ((Document)p.get("stats")).getDouble("kd"));
        }
        System.out.println();
    }

    // Aggregation: $lookup players->teams, $group by team, $sort, $project
    void aggregate() {
        System.out.println("--- AGGREGATION: players by team ---");
        System.out.println("Stages: $lookup -> $unwind -> $group -> $sort -> $project\n");

        var players = db.getCollection("players");
        List<Bson> pipe = Arrays.asList(
            // $lookup: join with teams
            Aggregates.lookup("teams", "team_id", "_id", "team_info"),
            // $unwind: flatten team_info
            Aggregates.unwind("$team_info"),
            // $group: by team name
            Aggregates.group("$team_info.name",
                Accumulators.sum("cnt", 1),
                Accumulators.avg("avg_rating", "$rating"),
                Accumulators.push("nicks", "$nick")),
            // $sort: by count desc
            Aggregates.sort(Sorts.descending("cnt")),
            // $project: format output
            Aggregates.project(Projections.fields(
                Projections.computed("team", "$_id"),
                Projections.include("cnt", "avg_rating", "nicks"),
                Projections.excludeId()))
        );

        for (var r : players.aggregate(pipe)) {
            System.out.printf("Team: %s | Players: %d | Avg rating: %.0f | Nicks: %s%n",
                r.getString("team"), r.getInteger("cnt"),
                r.getDouble("avg_rating"), r.getList("nicks", String.class));
        }
    }
}
